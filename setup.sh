#!/usr/bin/env bash
# =============================================================================
#  setup.sh — bootstrap naga's Arch + Hyprland setup (Catppuccin Mocha rice
#  + terminal dev environment) on a fresh-ish Arch system.
#
#  USAGE:   bash setup.sh
#  SAFE:    asks before big steps, backs up any configs it would overwrite.
#
#  ⚠️  REVIEW THIS SCRIPT BEFORE RUNNING IT. Never run a stranger's setup
#      script blindly. It installs packages, applies dotfiles to $HOME,
#      and enables system services.
# =============================================================================
set -uo pipefail

REPO_URL="https://github.com/Nagavignesh1729/dotfiles.git"
DOTGIT="$HOME/.dotfiles"
BACKUP="$HOME/.config-backup-$(date +%s)"

c_mauve='\033[1;35m'; c_yellow='\033[1;33m'; c_red='\033[1;31m'; c_off='\033[0m'
say()  { printf "\n${c_mauve}==>${c_off} %s\n" "$*"; }
warn() { printf "${c_yellow}[!]${c_off} %s\n" "$*"; }
die()  { printf "${c_red}[x]${c_off} %s\n" "$*" >&2; exit 1; }
ask()  { read -rp "$(printf "${c_yellow}?${c_off} %s [y/N] ")" _a; [[ "${_a,,}" == y* ]]; }

# dotfiles bare-repo helper
config() { git --git-dir="$DOTGIT" --work-tree="$HOME" "$@"; }

# ---------------------------------------------------------------------------
# 0. Preflight
# ---------------------------------------------------------------------------
[[ $EUID -eq 0 ]] && die "Run as your normal user, NOT root (the script sudo's when needed)."
command -v pacman >/dev/null || die "This script is for Arch-based distros (no pacman found)."
ping -c1 -W3 archlinux.org >/dev/null 2>&1 || warn "No internet? Package installs may fail."

say  "This installs packages, applies dotfiles to \$HOME, and enables a few services."
say  "Overwritten configs are backed up to: $BACKUP"
ask  "Proceed?" || { echo "Aborted."; exit 0; }

# ---------------------------------------------------------------------------
# 1. Essentials: base-devel + git (needed for AUR + cloning)
# ---------------------------------------------------------------------------
say "Installing base-devel + git..."
sudo pacman -S --needed --noconfirm base-devel git || die "pacman failed."

# ---------------------------------------------------------------------------
# 2. Clone the bare dotfiles repo and check it out (with backup of conflicts)
# ---------------------------------------------------------------------------
if [[ ! -d "$DOTGIT" ]]; then
  say "Cloning dotfiles (bare repo) into $DOTGIT ..."
  git clone --bare "$REPO_URL" "$DOTGIT" || die "Clone failed."
fi
say "Applying dotfiles to \$HOME (backing up any conflicts)..."
mkdir -p "$BACKUP"
# Back up EVERY conflicting file git lists (not just dotfiles: also setup.sh,
# README.md, pkglists, screenshots/, plus the user's existing .bashrc etc.),
# then retry. Loop because resolving one batch can reveal more.
tries=0
until config checkout 2>/tmp/_cf_co; do
  tries=$((tries + 1))
  [ "$tries" -gt 4 ] && die "Checkout still failing after backups; resolve manually (backups in $BACKUP)."
  awk '/would be overwritten/{f=1;next} /^[^[:space:]]/{f=0} f&&NF{gsub(/^[[:space:]]+/,"");print}' /tmp/_cf_co \
  | while read -r rel; do
      [ -e "$HOME/$rel" ] || continue
      mkdir -p "$BACKUP/$(dirname "$rel")"
      mv "$HOME/$rel" "$BACKUP/$rel" 2>/dev/null || true
    done
done
config config --local status.showUntrackedFiles no
say "Dotfiles applied. (Run 'config status' later; alias is in config.fish.)"

# ---------------------------------------------------------------------------
# 3. Packages — official repos (pkglist is authoritative; fallback list below)
# ---------------------------------------------------------------------------
ESSENTIALS=(
  hyprland hyprlock hypridle hyprpicker xdg-desktop-portal-hyprland
  waybar swaync wofi wlogout kitty fish starship fastfetch btop htop cava
  neovim ripgrep fd fzf bat eza zoxide lazygit git-delta github-cli jq
  ruff lua-language-server tree-sitter-cli uv fnm unzip
  wl-clipboard grim slurp swappy brightnessctl playerctl wlsunset atuin
  thunar tumbler kvantum qt5ct qt6ct nwg-look nwg-displays
  papirus-icon-theme ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji
  pipewire wireplumber pavucontrol blueman polkit
  thermald tlp fwupd udisks2
)
if [[ -f "$HOME/pkglist-offcial.txt" ]]; then
  say "Installing official packages from pkglist-offcial.txt ..."
  sudo pacman -S --needed --noconfirm - < "$HOME/pkglist-offcial.txt" \
    || warn "Some official packages failed (hardware-specific ones are expected to)."
else
  warn "No pkglist-offcial.txt found — installing the essential fallback set."
  sudo pacman -S --needed --noconfirm "${ESSENTIALS[@]}" || warn "Some packages failed."
fi

# ---------------------------------------------------------------------------
# 4. AUR helper (yay) + AUR packages
# ---------------------------------------------------------------------------
if ! command -v yay >/dev/null; then
  if ask "Install 'yay' (AUR helper)? Needed for AUR packages (eww, ananicy-cpp, etc.)"; then
    tmp="$(mktemp -d)"; git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay"
    ( cd "$tmp/yay" && makepkg -si --noconfirm ) || warn "yay install failed."
    rm -rf "$tmp"
  fi
fi
if command -v yay >/dev/null && [[ -f "$HOME/pkglist-aur.txt" ]]; then
  say "Installing AUR packages from pkglist-aur.txt ..."
  yay -S --needed --noconfirm - < "$HOME/pkglist-aur.txt" || warn "Some AUR packages failed."
fi

# ---------------------------------------------------------------------------
# 5. Shell + toolchains
# ---------------------------------------------------------------------------
if command -v fish >/dev/null && ask "Set fish as your default shell?"; then
  chsh -s "$(command -v fish)" || warn "chsh failed (do it manually: chsh -s /usr/bin/fish)."
fi
if command -v fnm >/dev/null; then
  say "Installing Node LTS via fnm..."
  export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env 2>/dev/null)" 2>/dev/null || true
  fnm install --lts && fnm default lts-latest || warn "fnm node install hiccup."
fi

# ---------------------------------------------------------------------------
# 6. Neovim — install plugins (parsers build lazily on first real open)
# ---------------------------------------------------------------------------
if command -v nvim >/dev/null; then
  say "Bootstrapping Neovim plugins (lazy.nvim sync)..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || warn "Lazy sync hiccup — run :Lazy in nvim."
fi

# ---------------------------------------------------------------------------
# 7. Services (hardware-aware)
# ---------------------------------------------------------------------------
say "Enabling services..."
sudo systemctl disable NetworkManager-wait-online.service 2>/dev/null || true
command -v systemctl >/dev/null && {
  # TLP for laptop power; mask the conflicting power-profiles-daemon
  if pacman -Q tlp &>/dev/null; then
    pacman -Q power-profiles-daemon &>/dev/null && sudo systemctl mask power-profiles-daemon.service 2>/dev/null
    sudo systemctl enable --now tlp.service 2>/dev/null || warn "tlp enable failed."
  fi
  # thermald is INTEL-ONLY — skip on AMD
  if grep -q GenuineIntel /proc/cpuinfo && pacman -Q thermald &>/dev/null; then
    sudo systemctl enable --now thermald 2>/dev/null || true
  else
    warn "Skipping thermald (not an Intel CPU)."
  fi
  pacman -Q ananicy-cpp &>/dev/null && sudo systemctl enable --now ananicy-cpp 2>/dev/null || true
  systemctl --user daemon-reload 2>/dev/null || true
}

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
say "Setup complete! 🎉  Final manual steps:"
cat <<'NOTES'
  1. Reboot, then start Hyprland (or pick it at your display manager).
  2. Regenerate your monitor layout (machine-specific):   nwg-displays
  3. First `nvim` launch finishes Treesitter parser builds automatically.
  4. AMD users: ensure 'amd-ucode' (not 'intel-ucode'); thermald was skipped.
  5. Backups of any overwritten configs:  the ~/.config-backup-* folder.
  6. Tweak wallpaper, and enjoy. Update dotfiles later with: config add/commit/push
NOTES
