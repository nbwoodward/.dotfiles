#!/bin/bash

#symlinks to go in home
homefiles=(.tmux .tmux.conf .tmux.conf.local .tmux.conf.osx .tmux.conf.linux .vim .vimrc .bashrc .zshrc.nick)

backup_dir=~/dev_bak

if [ ! -d "$backup_dir" ]; then
    echo creating $backup_dir
    mkdir $backup_dir
fi

for f in ${homefiles[@]}; do
    if [ -L ~/$f ]; then
        echo Deleting symlink ~/$f "->" $(echo `readlink ~/$f`)
        rm ~/$f
    elif [ -f ~/$f ]; then
        echo Moving file ~/$f to $backup_dir
        mv ~/$f $backup_dir
    elif [ -d ~/$f ]; then
        echo Moving directory ~/$f to $backup_dir
        mv ~/$f $backup_dir
    else
        echo Creating new symlink ~/$f
    fi

    ln -s ~/.dotfiles/$f ~/$f
done

#Ensure that ~/.config exists
mkdir -p ~/.config

#link ~/.config/nvim -> ~/.dotfiles/.vim
f=nvim
if [ -L ~/.config/$f ]; then
    echo Deleting symlink ~/.config/$f "->" $(echo `readlink ~/.config/$f`)
    rm ~/.config/$f
elif [ -f ~/.config/$f ]; then
    echo Moving file ~/.config/$f to $backup_dir
    mv ~/.config/$f $backup_dir
elif [ -d ~/.config/$f ]; then
    echo Moving file ~/.config/$f to $backup_dir
    mv ~/.config/$f $backup_dir
else
    echo Creating new symlink ~/.config/$f "->" ~/.dotfiles/.vim
fi

ln -s ~/.dotfiles/.vim ~/.config/$f


#Install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "# Local Zsh" >> $HOME/.zshrc.local

echo "source $HOME/.zshrc.nick" >> $HOME/.zshrc
echo "source $HOME/.zshrc.local" >> $HOME/.zshrc

echo '" Local Vimrc' >> $HOME/.vimrc.local
cp nbw.zsh-theme $HOME/.oh-my-zsh/themes
cp nbw.zsh-theme $HOME/.oh-my-zsh/themes/robbyrussell.zsh-theme

source $HOME/.zshrc


# Install TMUX
git clone https://github.com/gpakosz/.tmux
ln -s -f .tmux/.tmux.conf $HOME/.tmux.conf


# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install RG on OSX
brew install ripgrep
