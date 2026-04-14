echo "be a good human"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nbw"
plugins=(git)

# Add asdf completions before oh-my-zsh runs compinit
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

source $ZSH/oh-my-zsh.sh

# PATH
export PATH="$HOME/.dotfiles/bin:$PATH"

# Tmux pane-specific history
if [[ $TMUX_PANE ]]; then
  HISTFILE=$HOME/.zsh_history_tmux/.zsh_history_tmux_${TMUX_PANE:1}
  TMUX_INDEX=$(tmux display -pt "${TMUX_PANE:?}" '#{pane_index}')
fi

# Aliases
alias ll='ls -alhFp'
alias lt='ls -hlatr'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias dev="cd ~/projects/dev"
alias cp="cp -r"
alias vb="nvim ~/.zshrc"
alias vbl="nvim ~/.zshrc.local"
alias sb="source ~/.zshrc"
alias hosts="cat /etc/hosts"
alias :q="exit"

# Git aliases
alias ggb="git log --decorate --graph --pretty --pretty=short --abbrev-commit"
alias ggl="git log --decorate --graph --pretty --all --pretty=short --abbrev-commit"
alias gg="git log --decorate --graph --pretty --all --pretty=oneline --abbrev-commit -20"
alias gb="git branch"
alias gd="git diff --cached"
alias gdn="git diff --cached --name-only"
alias gm="git merge -ff"
alias gp="git pull -ff"
alias gc="git commit -m"
alias gs="git status"
alias chkb="git checkout -b"

alias p3="python3"
alias p2="python2.7"
alias python="python3"
alias pyserver="python3 -m http.server 5555"
alias mkvenv="python3 -m venv .venv && source .venv/bin/activate"
alias venv="source .venv/bin/activate"

alias t="tmux a"
alias tat="tmux a -t"

alias listening='lsof -iTCP -sTCP:LISTEN -n -P'

# FZF
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!{node_modules/*,.git/*}"'
source ~/.fzf.zsh
bindkey -r '\ec' fzf-cd-widget

# Functions
function reset-soft() {
  branch=`git rev-parse --abbrev-ref HEAD`

  git checkout $1
  git pull
  git checkout $branch
  git merge $1 -m "merge $1"
  git reset --soft $1
}

function mf() {
    GIT_ROOT="$(git rev-parse --show-toplevel)"
    echo "...formatting ${GIT_ROOT}"

    if [ -f "${GIT_ROOT}/mix.exs" ]; then
      cd "${GIT_ROOT}" && mix format && cd - > /dev/null
    elif [ -f "${GIT_ROOT}/package.json" ]; then
      cd $GIT_ROOT && prettier --write `git diff --name-only --diff-filter=MA HEAD`
    else
      echo "Unable to determine project type"
    fi
}

# Machine-local overrides (not version controlled)
source ~/.zshrc.local
