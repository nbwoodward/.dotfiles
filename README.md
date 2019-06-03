# Nick's Bash/Tmux/Neovim Development Environment

This is a collection of environment files for bash, tmux, and vim/neovim.


## Installation

MacOS:
```
brew install neovim
brew install tmux
brew install reattach-to-user-namespace
git clone https://github.com/nbwoodward/devfiles.git ~/devfiles
cd devfiles
./mklinks.sh
echo "source ~/.bashrc" >> ~/.profile
```

Ubuntu:
```
apt-get install neovim
apt-get install tmux
git clone https://github.com/nbwoodward/devfiles.git ~/devfiles
cd devfiles
./mklinks.sh
```

CentOS:
```
yum install neovim
git clone https://github.com/nbwoodward/devfiles.git ~/devfiles
cd devfiles
# As of writing this, yum doesn't have the right tmux version, so centos.sh downloads and compailes tmux 2.4
./centos.sh
./mklinks.sh
```


## Usage

When using neovim for the first time run `:PlugInstall` to install vim plugins.

Each vim plugin is included in .vimrc as a github `<repo owner>/<repo name>`. So you can look up documentation for
the `scrooloose/nerdtree` plugin at `https://github.com/scrooloose/nerdtree`.
