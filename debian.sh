#!/bin/bash

# One-shot setup for a fresh Debian/Ubuntu box.
# Installs packages via apt, then links dotfiles into ~ and installs
# oh-my-zsh, oh-my-tmux, and fzf.

set -e

# Install packages via apt
sudo apt update
sudo apt install -y neovim tmux zsh git curl ripgrep build-essential

# symlinks to go in home
homefiles=(.tmux .tmux.conf .tmux.conf.local .tmux.conf.osx .tmux.conf.linux .vim .vimrc .vimrc.cmp .vimrc.treesitter .bashrc .zshrc .alacritty.toml)

backup_dir=~/dev_bak

if [ ! -d "$backup_dir" ]; then
    echo creating $backup_dir
    mkdir $backup_dir
fi

for f in "${homefiles[@]}"; do
    if [ -L ~/$f ]; then
        echo "Deleting symlink ~/$f -> $(readlink ~/$f)"
        rm ~/$f
    elif [ -f ~/$f ]; then
        echo "Moving file ~/$f to $backup_dir"
        mv ~/$f $backup_dir
    elif [ -d ~/$f ]; then
        echo "Moving directory ~/$f to $backup_dir"
        mv ~/$f $backup_dir
    else
        echo "Creating new symlink ~/$f"
    fi

    ln -s ~/.dotfiles/$f ~/$f
done

# Ensure that ~/.config exists
mkdir -p ~/.config

# link ~/.config/nvim -> ~/.dotfiles/.vim
f=nvim
if [ -L ~/.config/$f ]; then
    echo "Deleting symlink ~/.config/$f -> $(readlink ~/.config/$f)"
    rm ~/.config/$f
elif [ -f ~/.config/$f ]; then
    echo "Moving file ~/.config/$f to $backup_dir"
    mv ~/.config/$f $backup_dir
elif [ -d ~/.config/$f ]; then
    echo "Moving directory ~/.config/$f to $backup_dir"
    mv ~/.config/$f $backup_dir
else
    echo "Creating new symlink ~/.config/$f -> ~/.dotfiles/.vim"
fi

ln -s ~/.dotfiles/.vim ~/.config/$f

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

# Install oh-my-zsh (unattended, keeps existing .zshrc)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

touch "$HOME/.zshrc.local"
echo "# Local Zsh" >> "$HOME/.zshrc.local"

touch "$HOME/.vimrc.local"
echo '" Local Vimrc' >> "$HOME/.vimrc.local"

cp nbw.zsh-theme "$HOME/.oh-my-zsh/themes"

# Install oh-my-tmux
if [ ! -d ~/.dotfiles/.tmux ]; then
    git clone https://github.com/gpakosz/.tmux ~/.dotfiles/.tmux
fi

# Install fzf
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi
