# for interactive shells

# do we have color support
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    COLOR_CAPABILITY=yes
else
    COLOR_CAPABILITY=
fi

# oh-my-zsh
# Path to your oh-my-zsh configuration.
ZSH=$HOME/src/contrib/oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mruser"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git django history-substring-search pass pip rsync themes virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# color capability?
if [ $COLOR_CAPABILITY ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && LS_COLOR_OPTION='--color=auto' || LS_COLOR_OPTION='-G'
  alias ls="ls $LS_COLOR_OPTION"
fi

source $HOME/.aliases

# interactive environment variables
export EDITOR='vim'
# I want plsql syntax highlighting when hitting \e in psql
export PSQL_EDITOR='vim -c "set syntax=plsql"'
# use my ls colors
if [ $COLOR_CAPABILITY ]
then
    eval $(dircolors ~/.dircolors-256dark)
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"s
fi

# no flow control in interactive shells
stty -ixon

