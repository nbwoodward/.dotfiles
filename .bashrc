# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#Default Umask
umask 022

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ "$force_color_prompt" = yes ]; then

    color_prompt=yes

#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi

fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    export TERM=xterm-color
    export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    export COLOR_NC='\e[0m' # No Color
    export COLOR_WHITE='\e[1;37m'
    export COLOR_BLACK='\e[0;30m'
    export COLOR_BLUE='\e[0;34m'
    export COLOR_LIGHT_BLUE='\e[1;34m'
    export COLOR_GREEN='\e[0;32m'
    export COLOR_LIGHT_GREEN='\e[1;32m'
    export COLOR_CYAN='\e[0;36m'
    export COLOR_LIGHT_CYAN='\e[1;36m'
    export COLOR_RED='\e[0;31m'
    export COLOR_LIGHT_RED='\e[1;31m'
    export COLOR_PURPLE='\e[0;35m'
    export COLOR_LIGHT_PURPLE='\e[1;35m'
    export COLOR_BROWN='\e[0;33m'
    export COLOR_YELLOW='\e[1;33m'
    export COLOR_GRAY='\e[0;30m'
    export COLOR_LIGHT_GRAY='\e[0;37m'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some ls aliases
alias ll='ls -alhFp'
alias lt='ls -hlatr'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'



# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#Add ~/bin to local path
export PATH=~/bin:$PATH

#Some useful aliases
alias grepr='grep -rsl --exclude *.svn*'
alias rmswp='rm .*.*.sw*'
alias :w="echo we\'re saved!"
alias :q="echo quit it!"
alias fullfperm="sudo find -type f -exec chmod 766  {} \;"
alias fulldperm="sudo find -type d -exec chmod 777 {} \;"
alias fullperm="sudo find -type f -exec chmod 766  {} \; ; sudo find -type d -exec chmod 777 {} \;"
alias standard_perm="find . -type f -exec chmod 666 {} \; ; find -type d -exec chmod 755 {} \;"
alias vb="nvim ~/.bashrc"
alias vbl="nvim ~/.bashrc.local"
alias sb="source ~/.bashrc"
alias hosts="cat /etc/hosts"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias cp="cp -r"
alias rrsync="rsync --rsh='ssh' --progress -av"
alias pyserver="python -m SimpleHTTPServer 8000"

#Some git aliases
alias ggb="git log --decorate --graph --pretty --pretty=short --abbrev-commit"
alias ggl="git log --decorate --graph --pretty --all --pretty=short --abbrev-commit"
alias gg="git log --decorate --graph --pretty --all --pretty=oneline --abbrev-commit -20"
alias gb="git branch"
alias gd="git diff --cached"
alias gdn="git diff --cached --name-only"

alias gm="git merge -ff"
alias gp="git pull -ff"

function ga() {
	git add .
  git diff --cached
}

function gc() {
	git checkout $1
  git pull --ff-only
}

#Some OSX Postgres support
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias pgstatus="pg_ctl -D /usr/local/var/postgres status"
alias pg_brew_stop="brew services stop postgresql"

alias p3="python3"
alias p2="python2.7"
alias en="source .env"
alias de="deactivate"

alias j6="julia6"
alias j7="julia7"
alias j1="julia1"

#TMUX
alias t="tmux a"
alias tat="tmux a -t"


#
# OSX Specific things
#
if [[ $(uname -s) == Darwin ]]; then
    function c(){
      echo caffeinating for $1 minute\(s\), Jimbo.
      let s=$1*60
      caffeinate -t $s
    }

    function rm () {
      local path
      for path in "$@"; do
        # ignore any arguments
        if [[ "$path" = -* ]]; then :
        else
          local dst=${path##*/}
          # append the time if necessary
          while [ -e ~/.Trash/"$dst" ]; do
            dst="$dst "$(date +%H-%M-%S)
          done
          mv "$path" ~/.Trash/"$dst"
        fi
      done
    }

    #color the ls output
    export LSCOLORS=ExgxcxdxfxegedabagExEx
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi


function makerun(){
	make $*
	./$*
}

function svnsize() {
svn list -vR $1|awk '{if ($3 !="") sum+=$3; i++} END {print "\ntotal size= " sum/1024000" MB" "\nnumber of files= " i}'

}


function grek(){
  echo grep -rl --exclude *.svn* $1 ${2:-.}
  grep -rl --exclude *.svn* $1 ${2:-.}
}


#Export default NODE_ENV
export NODE_ENV="development"

#Not sure if this is needed.
#if [ -f /usr/libexec/java_home ]; then
    #export JAVA_HOME=$(/usr/libexec/java_home)
#fi

#Automatically soruce .env files on OSX when you cd into a dir
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if [ -f /usr/local/opt/autoenv/activate.sh ]; then
    source /usr/local/opt/autoenv/activate.sh
fi


#
# Source ~/.bashrc.local for local bash definitions like aliases, etc.
#
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
