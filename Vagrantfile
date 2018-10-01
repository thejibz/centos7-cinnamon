# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	if Vagrant.has_plugin?("vagrant-proxyconf")
		# config.proxy.http     = "http://proxy:3128/"
		# config.proxy.https    = "http://proxy:3128/"
		# config.proxy.no_proxy = "localhost,127.0.0.1"
	end

	config.vm.box = "centos/7"

	config.vm.provider "virtualbox" do |v|
		v.gui = true
		# Set the video memory to 128Mb:
		v.customize ["modifyvm", :id, "--vram", "128"]
		# Enable 3D acceleration:
		v.customize ["modifyvm", :id, "--accelerate3d", "on"]
		
		v.memory = "8096"
		v.cpus = "4"
		v.name = "CentOS-7-Cinnamon"
	end

	#
	# prerequisites
	#
	config.vm.provision "shell", inline: "localectl set-keymap fr && localectl set-x11-keymap fr"
	config.vm.provision "shell", path: "./setup/setup_dnf.sh"
	config.vm.provision "shell", path: "./setup/setup_git.sh"
	config.vm.provision "shell", path: "./setup/setup_selinux.sh"

	#
	# zsh setup
	#
	config.vm.provision "shell", path: "setup/setup_homyzsh.sh"
	config.vm.provision "file", source: "./files/.zshrc", destination: "/home/vagrant/.zshrc"

	#
	# ssh private keys setup
	#
	# config.vm.provision "file", source: "C:\\Keys\\gitlab\\id_rsa_gitlab", destination: "/home/vagrant/.ssh/id_rsa_gitlab"
	# config.vm.provision "shell", path: "./setup/setup_ssh.sh"

	#
	# cinnamon setup
	#
	config.vm.provision "shell", path: "./setup/setup_cinnamon.sh"

	#
	# turbovnc setup
	#
	#config.vm.provision "shell", path: "./setup/setup_turbovnc.sh"

	#
	# docker setup
	#
	config.vm.provision "shell", path: "./setup/setup_docker.sh"

	#
	# nodejs setup
	#
	config.vm.provision "shell", path: "./setup/setup_nodejs.sh"

	#
	# vscode setup
	#
	config.vm.provision "shell", path: "./setup/setup_vscode.sh"

	#
	# setup workspace
	#
	config.vm.provision "file", source: "./files/Makefile", destination: "/tmp/Makefile"
	config.vm.provision "shell", path: "./setup/setup_workspace.sh"

	#
	# cleanup
	#
	config.vm.provision "shell", inline: "rm -rf /tmp/*"


	#
	# sync folders setup
	#
	config.vm.synced_folder "C:\\Utilisateurs\\a528561\\workspace\\shared", "/shared", disabled: "true"
	# workspace
	#config.vm.synced_folder "C:\\Utilisateurs\\a528561\\workspace", "/workspace"
	# maven
	#config.vm.synced_folder "C:\\Utilisateurs\\a528561\\.m2", "/home/vagrant/.m2"
	# gradle
	#config.vm.synced_folder "C:\\Utilisateurs\\a528561\\.gradle", "/home/vagrant/.gradle"
	# docker volumes 
	#config.vm.synced_folder "C:\\Utilisateurs\\a528561\\volumes", "/var/lib/docker/volumes"

	#
	# port forwarding setup
	#

	# turbovnc
	# config.vm.network "forwarded_port", guest: 5801, host: 5801
	# config.vm.network "forwarded_port", guest: 5901, host: 5901

	# docker host
	config.vm.network "forwarded_port", guest: 2375, host: 2375
	
	# oc cluster
	#config.vm.network "forwarded_port", guest: 8443, host: 8443

	# web servers
	config.vm.network "forwarded_port", guest: 8080, host: 8080
	config.vm.network "forwarded_port", guest: 9990, host: 9990
	config.vm.network "forwarded_port", guest: 8500, host: 8500
	config.vm.network "forwarded_port", guest: 9080, host: 9080
	config.vm.network "forwarded_port", guest: 8000, host: 8000

	# apigee
	config.vm.network "forwarded_port", guest: 9000, host: 9000
	config.vm.network "forwarded_port", guest: 9001, host: 9001
	config.vm.network "forwarded_port", guest: 8079, host: 8079

end