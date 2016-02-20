
Vagrant.configure(2) do |config|
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/trusty64" #vm.box = "apache"#
    web.vm.hostname = "lamp"
    web.vm.network "private_network", ip: "192.168.50.40"
    web.vm.provision :shell, path: "bootstrap-lamp.sh"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/trusty64" #vm.box = "apache"#
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.50.4"
    db.vm.provision :shell, path: "bootstrap-db.sh"
  end

  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "ubuntu/trusty64" #vm.box = "apache"#
    puppet.vm.hostname = "puppet"
    puppet.vm.network "private_network", ip: "192.168.50.2"
    puppet.vm.provision :shell, path: "bootstrap-srv.sh"
    config.vm.provider "virtualbox" do |v|
      v.memory = 8192
    end
  end
end
