#!/bin/bash
set -e

me="setup_workspace.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

mkdir -p /workspace
cp /tmp/Makefile /workspace/Makefile
chown -R vagrant:vagrant /workspace
runuser -l vagrant bash -c "cd /workspace && make workspace"

echo -e "# DONE: $me #"