Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/xenial64"
	config.vm.provision "install-deps", type: "shell", path: "install-deps.sh"
	config.vm.provision "build-windows", type: "shell", path: "build-win.sh", privileged: false
	config.vm.provision "build-linux", type: "shell", path: "build-linux.sh", privileged: false
end
