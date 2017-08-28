# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/markowski/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PATH=$HOME/bin:$PATH:/usr/local/MATLAB/R2014a/bin
export PATH=$PATH:$HOME/github/codeviz:$HOME/github/source-probe

PS1=$'\n%{\e[1;32m%}%B%n@%M%b %{\e[1;0m%}%~%{\e[0m%}\n$ '
#PS1=$'\n\[\e[1;32m\]\u@\h \[\e[1;0m\]\w\[\e[0m\]\[\e[1;30m\]'`
#   `'$(__git_ps1 "[%s]")\[\e[1;0m\]\n$ '

# Load aliases
[[ -f ~/.aliases ]] && . ~/.aliases
