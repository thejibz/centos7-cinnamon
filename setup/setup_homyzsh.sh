#!/bin/bash
set -e

me="setup_homyzsh.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

dnf install -y zsh
usermod -s /bin/zsh root
usermod -s /bin/zsh vagrant
runuser -l vagrant sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "# DONE: $me #"