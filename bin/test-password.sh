#!/bin/sh

# Store the first argument with a name
password=$1

# Store the 40 character SHA1 hash
sha1=$(echo -n "$password" | sha1sum | cut -c 1-40)

# Save the first 5 and last 35 SHA1 chunks in separate variables
sha1_a=${sha1:0:5}
sha1_b=${sha1:5:40}

# Use the k-Anonymity API to fetch a collection of pwned passwords that share
# the same 5 characters of the SHA1
sha1list=$(wget -q -O - https://api.pwnedpasswords.com/range/$sha1_a)

# Does our password's last 35 character SHA1 chunk match any in the list?
echo $sha1list | grep --ignore-case --quiet $sha1_b
rc=$?

if [ $rc -eq 0 ]; then
    echo '*****************************'
    echo "* The password is NOT safe! *"
    echo '*****************************'
else
    echo '*****************************'
    echo "* Password is safe :)       *"
    echo '*****************************'
fi
