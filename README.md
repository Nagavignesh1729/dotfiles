# 🪟 Arch + Hyprland Dotfiles — "Mocha Neon"

A lean, fast, fully-themed **Arch Linux + [Hyprland](https://hypr.land)** desktop in the
**Catppuccin Mocha** palette (mauve accent), plus a complete terminal-first dev
environment. One script gets you the whole thing.

![rice](https://catppuccin.com) <!-- replace with a screenshot URL -->

---

## ✨ What you get
- **Hyprland** compositor + **Waybar** (island bar), **swaync** notifications,
  **eww** dashboard, **hyprlock** / **hypridle**, **wofi** / **wlogout**
- **Catppuccin Mocha** everywhere — GTK, Qt (Kvantum), terminal, editor
- **Terminal dev env**: Neovim IDE (LSP, Treesitter, completion, dashboard, `<Space>?`
  cheat sheet), `uv` (Python), `fnm` (Node), and a fast CLI kit (ripgrep, fd, fzf, bat,
  eza, zoxide, lazygit, git-delta)
- **Thunar** file manager, **kitty** terminal, **fish** shell + **starship** prompt
- Performance/power tuning: zram-friendly sysctls, `tlp`, `thermald` (Intel), `ananicy-cpp`

---

## 🚀 Quick start (one command)

> **Requirements:** a working **Arch Linux** install (base system + a user account +
> internet). You do **not** need Hyprland pre-installed — the script installs it.

```bash
# 1. grab the setup script
curl -fsSLO https://raw.githubusercontent.com/Nagavignesh1729/dotfiles/main/setup.sh

# 2. READ IT (always review scripts before running), then run it:
less setup.sh
bash setup.sh
```

The script will:
1. Install official + AUR packages (from the included `pkglist-*.txt`)
2. Clone these dotfiles (bare repo) and apply them to your `$HOME` (backing up conflicts)
3. Set up fish, Node (`fnm`), Neovim plugins, and enable services
4. Print final manual steps

Then **reboot**, log into Hyprland, run `nwg-displays` to set your monitors, and you're done.

---

## 🛠️ Manual install (if you prefer, or the script fails)

<details>
<summary>Click to expand step-by-step</summary>

```bash
# packages (or: sudo pacman -S --needed - < pkglist-offcial.txt)
sudo pacman -S --needed hyprland waybar swaync wofi wlogout kitty fish starship \
  neovim ripgrep fd fzf bat eza zoxide lazygit git-delta uv fnm thunar tumbler \
  kvantum qt6ct nwg-look nwg-displays papirus-icon-theme tree-sitter-cli \
  ttf-jetbrains-mono-nerd pipewire wireplumber wl-clipboard grim slurp tlp

# AUR (need an AUR helper like yay): eww, ananicy-cpp, etc.
yay -S --needed - < pkglist-aur.txt

# apply dotfiles (bare-repo method)
git clone --bare https://github.com/Nagavignesh1729/dotfiles.git $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
mkdir -p ~/.config-backup
config checkout 2>&1 | grep -E "^\s+\." | awk '{print $1}' \
  | while read f; do mkdir -p ~/.config-backup/$(dirname "$f"); mv ~/"$f" ~/.config-backup/"$f"; done
config checkout
config config --local status.showUntrackedFiles no

# shell + toolchains
chsh -s /usr/bin/fish
fnm install --lts && fnm default lts-latest
nvim --headless "+Lazy! sync" +qa     # install nvim plugins
```
</details>

---

## ⚠️ Hardware / per-machine notes
These configs were built on an **Intel/Lenovo** laptop. On other hardware, adjust:
- **CPU microcode:** use `amd-ucode` instead of `intel-ucode` on AMD.
- **`thermald`** is **Intel-only** — the script skips it on AMD automatically.
- **Monitors:** `~/.config/hypr/monitors.conf` is machine-specific — regenerate with
  **`nwg-displays`** after install.
- Any GPU drivers (`mesa`, `vulkan-*`) per your card.

---

## ⌨️ Key bindings (Hyprland)
| Key | Action |
|---|---|
| `Super + Return` | terminal (kitty) |
| `Super + E` | file manager (Thunar) |
| `Super + D` | app launcher (wofi) |
| `Super + \`` | eww dashboard |
| `Super + /` | keybind cheatsheet |
| `Super + S` | scratchpad · `Super + P` color picker |

In **Neovim**: leader is `Space` — `<Space>ff` find files, `<Space>fg` grep, `<Space>e`
file tree, `<Space>?` cheat sheet. (Full sheet: `~/nvim-cheatsheet.md`.)

---

## 🔄 Updating (how the bare repo works)
The git db lives in `~/.dotfiles`; `$HOME` is the work-tree. Use the `config` alias
(set in `config.fish`) instead of `git` — it tracks the **live** files in place:
```bash
config add ~/.config/whatever     # no copying — the real file is tracked
config status                     # review before committing
config commit -m "what changed"
config push
```
A normal project (`~/code/x` with its own `.git`) is driven by plain `git` and is
completely separate — no conflict.

---

## 🔒 No secrets here
Nothing sensitive is committed — no SSH/GPG keys, no GitHub/`gh` token, no `atuin` key,
no browser data, no passwords. **If you fork this, keep it that way:** never `config add`
`~/.ssh`, `~/.config/gh`, `~/.config/atuin`, `~/.st/`, or any `.env`/token file.

## 🙏 Credits
[Catppuccin](https://catppuccin.com) · [Hyprland](https://hypr.land) ·
[lazy.nvim](https://github.com/folke/lazy.nvim) · the Arch + r/unixporn community.
PRs/issues welcome.
