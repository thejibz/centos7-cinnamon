#!/bin/bash
set -e

me="setup_git.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

dnf install -y git

# setup proxy conf
# git config --global http.proxy http://proxy:3128/


echo -e "# DONE: $me #"