if status is-interactive
# Commands to run in interactive sessions can go here
# Aliases
alias ls="eza --icons"
alias ll="eza -lah --icons"
alias cat="bat"
#alias grep="rg"

# Better navigation
zoxide init fish | source

# Starship prompt
starship init fish | source

# Greeting
function fish_greeting
	figlet (uname -n | string upper) | lolcat
	fastfetch
end

alias qwenlocal='cd ~/agent-lab/tools/llama.cpp && LD_LIBRARY_PATH=./build/bin ./build/bin/llama-cli -m ~/agent-lab/models/Qwen2.5-Coder-7B-Instruct-Q4_K_M.gguf -t 4 --prio 2'

fzf --fish | source
    atuin init fish --disable-up-arrow | source
end

# Created by `pipx` on 2026-05-31 07:42:40
set PATH $PATH $HOME/.local/bin

# === dev environment (nvim/uv/fnm) — added 2026-06-07 ===
if status is-interactive
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    fnm env --use-on-cd | source
    alias vim="nvim"
    alias vi="nvim"
    alias lt="eza --tree --level=2 --icons"
    alias la="eza -a --icons"
    alias lg="lazygit"
end
