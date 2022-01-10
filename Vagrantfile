Vagrant.configure("2") do |config|
  config.vm.box = "luminositylabsllc/bento-ubuntu-20.04-arm64"
  config.vm.network "private_network", ip: "172.30.1.5"
  config.ssh.host = "127.0.0.1"
  config.ssh.port = 2322
  config.vm.network "forwarded_port", guest: 22, host: 2322
  config.vm.provider "parallels" do |prl|
    prl.name = "my_vm"
    prl.cpus = 2
    prl.memory = 4048
    prl.update_guest_tools = true
  end
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.auto_update = false
  end
  config.vm.provision "shell" do |s|
    s.path = "setup.sh"
  end 

end

