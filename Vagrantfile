Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/xenial64"
	config.vm.provision :shell, path: "install-deps.sh"
	config.vm.provision :shell, path: "build-win.sh", privileged: false
end
