#!/bin/bash
set -e

me="setup_ssh.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

# set permission for private keys
for possiblekey in /home/vagrant/.ssh/id_*; do
    if grep -q PRIVATE "$possiblekey"; then
        chmod 700 "$possiblekey"
    fi
done


echo -e "# DONE: $me #"