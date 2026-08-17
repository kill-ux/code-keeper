# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "sandbox" do |sandbox|

    sandbox.vm.box = "bento/ubuntu-24.04"
    sandbox.vm.box_version = "202510.26.0"
    sandbox.vm.network "private_network", ip: "192.168.56.20"

    sandbox.vm.provider "virtualbox" do |vb|
      vb.cpus = 4
      vb.memory = 6144
    end

    sandbox.vm.provision "shell", inline: <<-SHELL
      #expend size
      lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
      resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv

      # setup swap
      SWAP_SIZE=3G
      if ! grep -q "swapfile" /etc/fstab; then
        fallocate -l ${SWAP_SIZE} /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap sw 0 0' >> /etc/fstab
      fi
    SHELL
  end
end
