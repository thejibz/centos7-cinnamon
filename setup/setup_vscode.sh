#!/bin/bash
set -e

me="setup_vscode.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

#
# install MS repos
#
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#
# install vscode
#
dnf install -y code

echo -e "# DONE: $me #"