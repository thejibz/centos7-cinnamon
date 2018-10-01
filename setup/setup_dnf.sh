#!/bin/bash
set -e

me="setup_dnf.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

yum install -y wget
wget -P /tmp http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//dnf-0.6.4-2.sdl7.noarch.rpm
wget -P /tmp http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/dnf-conf-0.6.4-2.sdl7.noarch.rpm
wget -P /tmp http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/python-dnf-0.6.4-2.sdl7.noarch.rpm
yum install -y /tmp/dnf-0.6.4-2.sdl7.noarch.rpm /tmp/dnf-conf-0.6.4-2.sdl7.noarch.rpm /tmp/python-dnf-0.6.4-2.sdl7.noarch.rpm || true

echo -e "# DONE: $me #"