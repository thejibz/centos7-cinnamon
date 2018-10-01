#!/bin/bash
set -e

me="setup_nodejs.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

#
# nodejs and npm
#
curl -sL https://rpm.nodesource.com/setup_8.x | bash -
dnf install -y nodejs gcc-c++ make
node --version
npm --version

#
# yarn
#
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
dnf install -y yarn
yarn --version

echo -e "# DONE: $me #"