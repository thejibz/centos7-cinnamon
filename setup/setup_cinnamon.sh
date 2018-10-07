#!/bin/bash
set -e

me="setup_cinamon.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

dnf install -y epel-release
wget -P /tmp https://rpmfind.net/linux/Mandriva/devel/cooker/x86_64/media/main/release/lib64exiv2_12-0.23-22-mdv2012.0.x86_64.rpm
dnf install -y /tmp/lib64exiv2_12-0.23-22-mdv2012.0.x86_64.rpm
dnf groupinstall -y "X Window System" 
dnf groupinstall -y "Cinnamon Desktop" 
dnf install -y lightdm 
runuser -l vagrant bash -c "echo \"exec /usr/bin/cinnamon-session\" >> /home/vagrant/.xinitrc"

# setup cinnamon as the defult target when login

systemctl isolate graphical.target
systemctl set-default graphical.target

# helpers for cinnamon
echo "sudo /usr/bin/python2 /usr/share/cinnamon/cinnamon-settings/cinnamon-settings.py" >> /home/vagrant/cinnamon-settings
chown vagrant:vagrant  /home/vagrant/cinnamon-settings
chmod +x /home/vagrant/cinnamon-settings

echo -e "# DONE: $me #"