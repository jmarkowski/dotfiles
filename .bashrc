#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If running as 'root', be safe and exit this script immediately
[[ "$(whoami)" = "root" ]] && return

# Check the window size and update LINES and COLUMNS after each command
shopt -s checkwinsize

# Correct minor spelling mistakes in cd command
shopt -s cdspell

# Limit recursive functions (see 'man bash')
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100

# Load environment
[[ -f ~/.env ]] && . ~/.env

# Load aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Load functions
[[ -f ~/.functions ]] && . ~/.functions

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Allow for auto-tab-completion of commands proceeded by sudo.
complete -cf sudo

###############################################################################
# BASH HISTORY
#   see bash(1)
###############################################################################
HISTCONTROL=ignoreboth  # Ignore lines beginning with space and duplicates
HISTSIZE=1000           # Number of commands to remember in command history
HISTFILESIZE=2000       # Number of lines contained in history file
shopt -s histappend     # Append to the history file, don't overwrite it

###############################################################################
# GIT
###############################################################################
source ~/bin/git-completion.bash
source ~/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"

###############################################################################
# FZF keybindings
#   Ctrl-T: select files in the midst of a prompt
#   Alt-C : quickly swithc to a selected directory
#   Ctrl-R: smart searching command history
###############################################################################
source /usr/share/fzf/key-bindings.bash
#source /usr/share/fzf/completion.bash

###############################################################################
# PROMPT STRINGS
###############################################################################
_set_prompt_strings() {
    PS1='[\u@\h \W]\$ '
    PS1='\n\[\e[1;32m\]\u@\h \[\e[1;0m\]\w\[\e[0m\]'`
       `'\[\e[1;38m\] $(__git_ps1 "(%s)")\[\e[1;0m\]\n$ '
}
_set_prompt_strings
unset -f _set_prompt_strings

###############################################################################
# BINDINGS
###############################################################################
# Allows <UP> and <DOWN> to be used for finding a command in history
# with some initial letters of the past command.
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Bind <CTRL+O> to open files directly with preferred application
bind -x '"\C-o": file="$(fzf --height 40% --reverse)" && [ -f "$file" ] && xdg-open "$file"'
