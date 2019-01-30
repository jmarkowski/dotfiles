#!/usr/bin/sh

pw=$1

sha1=$(echo -n "$1" | sha1sum)
sha1=${sha1:0:40}

sha1sub=${sha1:0:5}
sha1upper=${sha1^^}
tmpfile=password-check.txt

# Use the k-Anonymity API to find out if a password is safe or not
wget -q -O $tmpfile https://api.pwnedpasswords.com/range/$sha1sub

echo PASSWORD: $pw
echo SHA1    : $sha1

echo "GREP results: "
echo grep ${sha1upper:5:40} $tmpfile -n
grep ${sha1upper:5:40} $tmpfile -n
rc=$?
rm -f $tmpfile

printf "\n"
if [ $rc -eq 0 ]; then
    echo '*****************************'
    echo "* The password is NOT safe! *"
    echo '*****************************'
else
    echo '*****************************'
    echo "* Password is safe :)       *"
    echo '*****************************'
fi
