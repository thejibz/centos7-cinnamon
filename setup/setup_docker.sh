#!/bin/bash
set -e

me="setup_docker.sh"
echo "#"
echo -e "# RUN: $me #"
echo "#"

#
#docker 
#
dnf install -y device-mapper-persistent-data lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y docker-ce

# proxy conf
# mkdir -p /etc/systemd/system/docker.service.d
# rm -f /etc/systemd/system/docker.service.d/http-proxy.conf || true
# tee /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
# [Service]
# Environment="HTTP_PROXY=http://proxy:3128"
# Environment="HTTPS_PROXY=http://proxy:3128"
# Environment="NO_PROXY=127.0.0.1,localhost"
# EOF

usermod -a -G docker vagrant
systemctl enable docker
systemctl daemon-reload
systemctl restart docker

runuser -l vagrant bash -c "docker run hello-world"

#
# docker-compose
#
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
runuser -l vagrant bash -c "docker-compose --version"

#
# alias
#
rm -f /etc/profile.d/docker.sh
tee /etc/profile.d/docker.sh <<EOF
export PATH=$PATH:/usr/local/bin/
alias dc='docker-compose'
alias dce='dc exec '
alias dcf='dc logs -f'
alias dti='docker exec -ti '
alias dcr='function _dcr(){ docker-compose stop $1; docker-compose rm -f $1; docker-compose build $1; docker-compose up -d $1 };_dcr'
alias dip="docker_ip $1"
alias dockerkillall='docker ps -q | xargs docker kill'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker ps -a -q | xargs docker rm'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker images -q -f dangling=true | xargs docker rmi'
alias dockercleanv='printf "\n>>> Deleting dangling volumes\n\n" && docker volume ls -q -f dangling=true | xargs docker volume rm'
alias dclean='dockercleanc || true && dockercleanv || true && dockercleani'
EOF

# start transproxy
chown vagrant:vagrant /home/vagrant/transparent_proxy
runuser -l vagrant bash -c "bash /home/vagrant/transparent_proxy"

echo -e "# DONE: $me #"