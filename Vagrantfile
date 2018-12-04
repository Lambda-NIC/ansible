# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.memory = "2048"
    virtualbox.cpus = "4"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
    sudo apt-get install -y python-pip
    sudo pip install proxmoxer
    sudo pip install requests --upgrade
  SHELL
end
