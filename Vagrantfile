Vagrant.configure("2") do |config|
  config.vm.box     = "ubuntu/trusty64"
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "base.pp"
    puppet.module_path    = "modules"
    puppet.facter = {
      "fqdn" => "mongobox"
    }
  end
end
