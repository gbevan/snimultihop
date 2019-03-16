# -*- mode: ruby -*-
# vi: set ft=ruby :

extras = <<-EOF
GOVER="1.11.3"

apt update
apt install locales

# Locales
locale-gen en_GB
locale-gen en_GB.UTF-8
update-locale en_GB

export DEBIAN_FRONTEND=noninteractive

# Install Go
wget -qO- https://dl.google.com/go/go${GOVER}.linux-amd64.tar.gz | \
  tar zx -C /usr/local/
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:~/go/bin' >> ~vagrant/.bashrc

echo '========================================================='
echo 'Ready...'
EOF

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "snimultihop-dev-1", primary: true do |ubuntu|
    ubuntu.vm.provision "shell", inline: extras
    ubuntu.vm.synced_folder "~/go", "/home/vagrant/go"
    ubuntu.vm.provider "docker" do |d|
      d.image = "gbevan/vagrant-ubuntu-dev:bionic"
      d.has_ssh = true
      # d.ports = ["3232:3232", "8300:8200", "27017:27017"]
      d.ports = ["8443:8443"]
      d.volumes = [
        "/etc/localtime:/etc/localtime:ro",
        "/etc/timezone:/etc/timezone:ro"
      ]
    end
  end

  config.vm.define "snimultihop-dev-2", primary: true do |ubuntu|
    ubuntu.vm.provision "shell", inline: extras
    ubuntu.vm.synced_folder "~/go", "/home/vagrant/go"
    ubuntu.vm.provider "docker" do |d|
      d.image = "gbevan/vagrant-ubuntu-dev:bionic"
      d.has_ssh = true
      # d.ports = ["3232:3232", "8300:8200", "27017:27017"]
      d.ports = ["8444:8443"]
      d.volumes = [
        "/etc/localtime:/etc/localtime:ro",
        "/etc/timezone:/etc/timezone:ro"
      ]
    end
  end
end
