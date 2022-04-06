#!/usr/bin/env bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NONE='\033[0m'

test_command () {
    command -v $1 >/dev/null 2>&1
    error_code=$?

    print "Testing '$1' ... \c";

    if [ ${error_code} -eq 1 ]; then
        print_red "ERROR";
    else
        print_green "OK";
    fi
}

print () {
    echo -e "    $*"
}

print_green () {
    echo -e "$GREEN""$*""$NONE"
}

print_red () {
    echo -e "$RED""$*""$NONE"
}

test_command 7z
test_command ag
test_command diffuse
test_command htop
test_command rsync
test_command sudo
test_command tree
test_command vim
test_command xarchiver
test_command zip

exit 0;
