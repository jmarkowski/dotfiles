#!/usr/bin/env bash

################################################################################
# GLOBALS
################################################################################
TARGET_DIR=$HOME
DOTFILES_DIR=$TARGET_DIR/.dotfiles

RED='\033[1;31m'
GREEN='\033[1;32m'
NONE='\033[0m'

################################################################################
# FUNCTIONS
################################################################################
error () {
    echo -e "$RED""ERROR: $*""$NONE"
}

bail () {
    error $*
    exit 99
}

check_command () {
    command -v $1 >/dev/null 2>&1 || bail "Command '$1' not found."
}

print () {
    echo -e "    $*"
}

input () {
    echo -n "    $*"
}

ask() {
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "    $1 [$prompt] " REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

################################################################################
# MAIN
################################################################################
# PRELIMINARY CONDITIONS #######################################################

check_command rsync
check_command git
check_command read
check_command find

print "Current directory: $PWD"
if [ $PWD != $DOTFILES_DIR ]; then
    bail "Script must be run within $DOTFILES_DIR";
fi

# If the $TMPDIR variable is set, then abort because... problems.
if ! [ -z ${TMPDIR+x} ]; then
    bail "TMPDIR is defined as $TMPDIR and boostrapping won't work"
fi

print "Fetching submodules ..."

git submodule init && git submodule update > /dev/null

TEMP_DIR=`mktemp -d`

# COPY TO TEMPORARY LOCATION ###################################################
print "Copied dotfiles into temporary directory: $TEMP_DIR"
rsync $DOTFILES_DIR/ $TEMP_DIR/ --exclude=.git \
                                --exclude=.gitmodules \
                                --exclude=bootstrap.sh \
                                --exclude=LICENSE \
                                --exclude=README.md \
                                 -ah

print ""
print "Copying dotfiles to: $TARGET_DIR/"
print ""

# COPY ALL FILES TO TARGET DIRECTORY ###########################################
for file in `find $TEMP_DIR/ -maxdepth 1 -type f -printf "%f\n"`
do
    do_copy=true
    target_file=$TARGET_DIR/$file
    is_file_different=$(rsync $TEMP_DIR/$file $TARGET_DIR/ -nc --out-format %i)

    if [[ $is_file_different ]] && [[ $is_file_different != *"+" ]] \
                                && ! ask " >>> Overwrite $target_file?"; then
        do_copy=false
    fi

    if $do_copy; then
        print "Copying $file ..."
        rsync $TEMP_DIR/$file $target_file -c
    else
        print "Skipping $file"
    fi
done

print ""
print "Updating directories to: $TARGET_DIR/ ..."
print ""

# COPY ALL DIRECTORIES TO TARGET DIRECTORY #####################################
for dir in `find $TEMP_DIR/ -maxdepth 1 -type d -printf "%f\n" | tail -n +2`
do
    do_copy=true
    target_dir=$TARGET_DIR/$dir
    is_dir_different=$(rsync $TEMP_DIR/$dir $TARGET_DIR -ncr --out-format %i)

    if [[ $is_dir_different ]] && [[ $is_dir_different == *"."* ]] \
        && ! ask " >>> Directory mismatch: $target_dir/. Update anyway?"; then
        do_copy=false
    fi

    if $do_copy; then
        print "Updating $dir/ ..."
        rsync $TEMP_DIR/$dir $TARGET_DIR -cr
    else
        print "Skipping $dir/"
    fi
done

# CLEANUP ######################################################################
print ""
print "Removed temporary directory"
rm -rf $TEMP_DIR

# CONFIGURATION ################################################################
print "Update git configuration file (enter blank to ignore):"
input "> Name : "
read name
input "> Email: "
read email

if [[ $name ]]; then
    git config --file $TARGET_DIR/.gitconfig user.name $name
fi
if [[ $email ]]; then
    git config --file $TARGET_DIR/.gitconfig user.email $email
fi

# DONE #########################################################################
print ""
print "$GREEN""Finished!""$NONE"

exit 0;
