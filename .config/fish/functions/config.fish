function config --wraps='git --git-dir=/home/naga/.dotfiles --work-tree=/home/naga' --description 'alias config git --git-dir=/home/naga/.dotfiles --work-tree=/home/naga'
    git --git-dir=/home/naga/.dotfiles --work-tree=/home/naga $argv
end
