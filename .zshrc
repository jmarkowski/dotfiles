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

# Load aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Load environment
[[ -f ~/.env ]] && . ~/.env

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

###############################################################################
# FUNCTIONS
###############################################################################

# Set man page colors to make man pages more readable.
man () {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

ex () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf  "$1" ;;
            *.tbz2)     tar -jxvf  "$1" ;;
            *.tar.gz)   tar -zxvf  "$1" ;;
            *.tgz)      tar -zxvf  "$1" ;;
            *.tar)      tar -xvf   "$1" ;;
            *.tar.xz)   tar -xvf   "$1" ;;
            *.bz2)      bunzip2    "$1" ;;
            *.gz)       gunzip     "$1" ;;
            *.zip)      unzip      "$1" ;;
            *.ZIP)      unzip      "$1" ;;
            *.7z)       7z x       "$1" ;;
            *.Z)        uncompress "$1" ;;
            *.rar)      unrar x    "$1" ;;
            '')         echo "usage: extract <file>" ;;
            *)          echo "'$1' unknown format. Unable to extract." ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Connect to the bluetooth adapter
bt () {
    case $1 in
        start) echo -e 'power on\nconnect 00:02:5B:00:FF:04\nquit' | bluetoothctl ;;
        stop) echo -e 'disconnect 00:02:5B:00:FF:04\npower off\nquit' | bluetoothctl ;;
    esac
}
