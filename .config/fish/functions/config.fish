function config --description 'dotfiles bare-repo wrapper'
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
