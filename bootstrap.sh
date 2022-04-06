#!/usr/bin/env bash

################################################################################
# GLOBALS
################################################################################
DEST_DIR=$HOME
DOTFILES_DIR=$DEST_DIR/.dotfiles

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
GREY='\033[1;37m'
NONE='\033[0m'

################################################################################
# FUNCTIONS
################################################################################
check_command () {
    command -v $1 >/dev/null 2>&1 || bail "Command '$1' not found."
}

print () {
    echo -e "    $*"
}

print_ok () {
    echo -e "$GREEN""$*""$NONE"
}

print_err () {
    echo -e "$RED""ERROR: $*""$NONE"
}

print_bold () {
    echo ""
    echo -e "$GREY""$*""$NONE"
    echo ""
}

bail () {
    print_err $*
    exit 99
}

input () {
    echo -n "    $*"
}

################################################################################
# MAIN
################################################################################
print_bold "STEP 1/7: Check environment"

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

print_bold "STEP 2/7: Fetch submodules"

print "Initializing submodules ... \c"
git submodule init && git submodule update > /dev/null
print_ok "OK"

print_bold "STEP 3/7: Create temporary working environment"

print "Creating working directory ... \c"
TEMP_DIR=`mktemp -d`
print_ok "OK"

print "Copying dotfiles into $TEMP_DIR ... \c"
rsync $DOTFILES_DIR/ $TEMP_DIR/ --exclude=.git \
                                --exclude=.gitmodules \
                                --exclude=bootstrap.sh \
                                --exclude=LICENSE \
                                --exclude=README.md \
                                 -ah
print_ok "OK"

print_bold "STEP 4/7: Copy working files to destination"

for file in `find $TEMP_DIR/ -maxdepth 1 -type f -printf "%f\n"`
do
    target_file=$DEST_DIR/$file
    is_file_different=$(rsync $TEMP_DIR/$file $DEST_DIR/ -nc --out-format %i)

    if [[ $is_file_different ]] && [[ $is_file_different != *"+" ]]; then
        mv $target_file ${target_file}.old
        print "Renamed existing $target_file to ${target_file}.old"
    fi

    print "Copying $file ... \c"
    rsync $TEMP_DIR/$file $target_file -c
    print_ok "OK"
done

print_bold "STEP 5/7: Copy working directories to destination"

for dir in `find $TEMP_DIR/ -maxdepth 1 -type d -printf "%f\n" | tail -n +2`
do
    target_dir=$DEST_DIR/$dir
    is_dir_different=$(rsync $TEMP_DIR/$dir $DEST_DIR -ncr --out-format %i)

    if [[ $is_dir_different ]] && [[ $is_dir_different == *"."* ]]; then
        mv $target_dir ${target_dir}.old
        print "Moved already existing $target_dir to ${target_dir}.old"
    fi

    print "Copying $dir/ ... \c"
    rsync $TEMP_DIR/$dir $DEST_DIR -cr
    print_ok "OK"
done

print_bold "STEP 6/7: Clean up"

print "Removing working directory ... \c"
rm -rf $TEMP_DIR
print_ok "OK"

print_bold "STEP 7/7: Configuration"

print "Update git configuration file (enter blank to ignore):"
input "> Name : "
read name
input "> Email: "
read email

if [[ $name ]]; then
    git config --file $DEST_DIR/.gitconfig user.name $name
fi
if [[ $email ]]; then
    git config --file $DEST_DIR/.gitconfig user.email $email
fi

print_bold "Finished!"

# POST-INSTALLATION ############################################################
print_bold "Post Installation tasks"
print "Install VIM plugins:"
print "    $ vim +PluginInstall +qall"
print ""

exit 0;
