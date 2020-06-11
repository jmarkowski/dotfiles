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

bail () {
    error $*
    exit 99
}

input () {
    echo -n "    $*"
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

print "Fetching submodules ... \c"
git submodule init && git submodule update > /dev/null
print_ok "OK"

TEMP_DIR=`mktemp -d`

# COPY TO TEMPORARY LOCATION ###################################################
print "Copying dotfiles into temporary directory: $TEMP_DIR ... \c"
rsync $DOTFILES_DIR/ $TEMP_DIR/ --exclude=.git \
                                --exclude=.gitmodules \
                                --exclude=bootstrap.sh \
                                --exclude=LICENSE \
                                --exclude=README.md \
                                 -ah
print_ok "OK"

print ""
print "Copying dotfiles to: $TARGET_DIR/"
print ""

# COPY ALL FILES TO TARGET DIRECTORY ###########################################
for file in `find $TEMP_DIR/ -maxdepth 1 -type f -printf "%f\n"`
do
    target_file=$TARGET_DIR/$file
    is_file_different=$(rsync $TEMP_DIR/$file $TARGET_DIR/ -nc --out-format %i)

    if [[ $is_file_different ]] && [[ $is_file_different != *"+" ]]; then
        mv $target_file ${target_file}.old
        print "Moved already existing $target_file to ${target_file}.old"
    fi

    print "Copying $file ... \c"
    rsync $TEMP_DIR/$file $target_file -c
    print_ok "OK"
done

print ""
print "Updating directories to: $TARGET_DIR/ ..."
print ""

# COPY ALL DIRECTORIES TO TARGET DIRECTORY #####################################
for dir in `find $TEMP_DIR/ -maxdepth 1 -type d -printf "%f\n" | tail -n +2`
do
    target_dir=$TARGET_DIR/$dir
    is_dir_different=$(rsync $TEMP_DIR/$dir $TARGET_DIR -ncr --out-format %i)

    if [[ $is_dir_different ]] && [[ $is_dir_different == *"."* ]]; then
        mv $target_dir ${target_dir}.old
        print "Moved already existing $target_dir to ${target_dir}.old"
    fi

    print "Copying $dir/ ... \c"
    rsync $TEMP_DIR/$dir $TARGET_DIR -cr
    print_ok "OK"
done

# CLEANUP ######################################################################
print ""
print "Cleaning up ... \c"
rm -rf $TEMP_DIR
print_ok "OK"

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
print_ok "Finished!"

# POST-INSTALLATION ############################################################
print ""
print "Post installation:"
print ""
print "Install VIM plugins:"
print "    $ vim +PluginInstall +qall"
print ""

exit 0;
