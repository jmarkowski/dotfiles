#
# ~/.zshrc
#

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory extendedglob nomatch notify
unsetopt beep
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Load environment
[[ -f ~/.env ]] && . ~/.env

# Load aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Load functions
[[ -f ~/.functions ]] && . ~/.functions

###############################################################################
# GIT
###############################################################################
source ~/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"

zstyle ':completion:*:*:git:*' script ~/bin/git-completion.zsh

###############################################################################
# PROMPT STRINGS
###############################################################################
setopt PROMPT_SUBST
#PS1=$'\n%{\e[1;32m%}%B%n@%M%b %{\e[1;0m%}%~%{\e[0m%}\n$ '
PS1=$'\n%{\e[1;32m%}%B%n@%M%b %{\e[1;0m%}%~%{\e[0m%} %{\e[1;30m%}$(__git_ps1 "(%s)")%{\e[1;0m%}\n$ '
