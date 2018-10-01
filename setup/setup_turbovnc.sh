#!/bin/bash
set -e

me="setup_turbovnc.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

curl -L https://sourceforge.net/projects/turbovnc/files/2.1.90%20%282.2beta1%29/turbovnc-2.1.90.x86_64.rpm/download --output /tmp/turbovnc-2.1.90.x86_64.rpm
dnf install -y /tmp/turbovnc*.rpm

#
# set passwd manually (value: passwd)
#
dnf install -y expect
rm -f /tmp/init_vncserver.sh || true
tee /tmp/init_vncserver.sh <<EOF
#!/bin/expect -f

spawn /opt/TurboVNC/bin/vncserver :1

expect "Password:" { send "passwd\r" }
expect "Verify:" { send "passwd\r" }
expect "Would you like to enter a view-only password (y/n)?" { send "n\r" }
sleep 5
interact
EOF
chmod +x /tmp/init_vncserver.sh
rm -f /root/.vnc/passwd || true
rm -f /home/vagrant/.vnc/passwd || true
runuser -l vagrant bash -c "expect /tmp/init_vncserver.sh"
cat /home/vagrant/.vnc/passwd

#
# set cinnamon desktop for vnc sessions
#
echo "cinnamon-session &" > /home/vagrant/.vnc/xstartup.turbovnc
chown vagrant:vagrant /home/vagrant/.vnc/xstartup.turbovnc
chmod 777 /home/vagrant/.vnc/xstartup.turbovnc

#
# create service
#
rm -f /etc/systemd/system/vncserver@:1.service || true
tee /etc/systemd/system/vncserver@:1.service <<EOF
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple
User=vagrant
Group=vagrant
PIDFile=/home/%u/.vnc/localhost.localdomain%i.pid
ExecStartPre=/bin/sh -c '/opt/TurboVNC/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/opt/TurboVNC/bin/vncserver %i -geometry 1680x1000 -alwaysshared 
ExecStop=/opt/TurboVNC/bin/vncserver -kill %i

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable vncserver@:1.service
systemctl start vncserver@:1.service

echo -e "# DONE: $me #"