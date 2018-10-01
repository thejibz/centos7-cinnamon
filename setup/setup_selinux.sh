#!/bin/bash
set -e

me="setup_selinux.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

# set selinux in permissive mode
sed -i -e 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
setenforce 0

echo -e "# DONE: $me #"