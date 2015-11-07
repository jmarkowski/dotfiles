#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$HOME/bin:$PATH
#export CDPATH=":$HOME" # include $HOME in cd-able path
#export VIMRUNTIME=$HOME/.vim

# Check the window size and update LINES and COLUMNS after each command
shopt -s checkwinsize

# Correct minor spelling mistakes in cd command
shopt -s cdspell

# Load aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

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
source ~/bin/git-completion.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"

###############################################################################
# PROMPT STRINGS
###############################################################################
PS1='[\u@\h \W]\$ '
PS1='\n\[\e[1;32m\]\u@\h \[\e[1;0m\]\w\[\e[0m\]\[\e[1;30m\]'`
   `'$(__git_ps1 "[%s]")\[\e[1;0m\]\n$ '

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

backup_home_external() {
    local dryrun='dry'
    case $1 in
        go)   dryrun=''   ;;
        test) dryrun='-n' ;;
        *) echo "Select 'go' (do backup) or 'test' to do dry run"; return; ;;
    esac
    rsync -av --update --modify-window=10 \
        --exclude '*.iso' \
        --exclude '.cache' \
        --exclude '.thumbnails' \
        --exclude '.local' \
        --exclude '.adobe' \
        --exclude '.mozilla' \
        $dryrun $HOME $2
}

backup () {
    local host=$1
    local dir=$2
    rsync ~/$dir/ $host:~/$dir/ -avzuP $3 $4
}

restore () {
    local host=$1
    local dir=$2
    rsync $host:~/$dir/ ~/$dir/ -avzuP $3 $4
}

# Display duplicate files in the current directory
find_duplicates () {
    find -not -empty -type f -printf "%s\n" | \
    sort -rn | \
    uniq -d | \
    xargs -I{} -n1 find -type f -size {}c -print0 | \
    xargs -0 md5sum | \
    sort | \
    uniq -w32 --all-repeated=separate
}

extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf  $1 ;;
            *.tbz2)     tar -jxvf  $1 ;;
            *.tar.gz)   tar -zxvf  $1 ;;
            *.tgz)      tar -zxvf  $1 ;;
            *.tar)      tar -xvf   $1 ;;
            *.bz2)      bunzip2    $1 ;;
            *.gz)       gunzip     $1 ;;
            *.zip)      unzip      $1 ;;
            *.ZIP)      unzip      $1 ;;
            *.Z)        uncompress $1 ;;
            '')         echo "usage: extract <file>" ;;
            *)          echo "Unable to extract: unknown format" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

vnc () {
    local disp=-1
    local host=$1

    case $2 in
        phys)       disp=0  ;;
        virt)       disp=1  ;;
        *)          echo "usage: vnc <host> (phys | virt)"; return ;;
    esac

    vncviewer -via $host -passwd ~/.vnc/$host localhost:$disp
}

vnc_start () {
    case $1 in
        # Access via port 5900
        phys)  x11vnc -display :0 -rfbauth ~/.x11vnc/passwd    ;;
        # Access via port 5901
        # (The 'dbus-launch vncserver ...' starts KDE in the vnc window.)
        # -alwaysshared: always treat incoming connections as shared
        # -localhost: only allow connections from same machine
        virt) dbus-launch vncserver -geometry 1920x1200 \
                                                   -nevershared -localhost :1 ;;
        *) echo "usage: vnc_start (phys | virt)" ;;
    esac
}

vnc_stop () {
    case $1 in
        phys) vncserver -kill :0  ;;
        virt) vncserver -kill :1  ;;
        list) vncserver -list ;;
        *) echo "usage: vnc_stop (phys | virt | list)" ;;
    esac
}

search () {
    grep -r $1 * --exclude-dir=other --exclude="jquery*" --exclude-dir=dev*
}

compare_dirs () {
    find $1 -type f -print0 | sort | xargs -0 sha1sum > ~/dir1
    find $2 -type f -print0 | sort | xargs -0 sha1sum > ~/dir2
    diffuse ~/dir1 ~/dir2
}
