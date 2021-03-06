Vagrant.configure("2") do |config|

  # Default box IP address
  # This is the IP address that your host will communicate to the guest
  # through. Change if you're already on the `192.168.33.x` subnet.
  private_ip = "192.168.33.15"

  # Enable agent forwarding on vagrant ssh commands. This allows you to use
  # identities established on the host machine inside the guest. See the manual
  # for `ssh-add`
  config.ssh.forward_agent = true
  config.ssh.forward_x11   = true

  config.vm.box     = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  
  config.vm.hostname = "dev-hadoop"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network(:private_network, :ip => private_ip)

  config.vm.provider :virtualbox do |vb|
    vb.customize(["modifyvm", :id, "--natdnshostresolver1", "off"  ])
    vb.customize(["modifyvm", :id, "--natdnsproxy1",        "off"  ])
    vb.customize(["modifyvm", :id, "--memory",              "1024" ])
  end

  config.vm.synced_folder(".", "/vagrant",
    :owner => "vagrant",
    :group => "vagrant",
    :mount_options => ['dmode=777','fmode=777']
  )

  current_dir = File.dirname(__FILE__)

  config.vm.provision(
    :shell,
    :inline => "chmod +x /vagrant/files/config/install.sh"
  )
  config.vm.provision(
    :shell,
    :inline => "/vagrant/files/config/install.sh"
  )

end