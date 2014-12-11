# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = [
  {
   :hostname => "master",
   :ip => "10"
  },
  {
   :hostname => "slave",
   :ip => "11"
  }
]


def node_config(hostname, node)
   node.hostname = hostname
   node.provision "puppet" do |puppet|
        puppet.manifests_path = "puppet/manifests"
	puppet.module_path = "puppet/modules"
	puppet.manifest_file = "nodes.pp"
	puppet.options = "--verbose --debug"
	#### Customizing facters for puppet
	puppet.facter = {
	   ### Tell the nodes.pp that virtualbox will be used
	   "is_vagrant" => true,
	   "is_compute_slave" => (hostname == "slave"),
	   "is_controller"  => (hostname == "master"),
	}
   end
end

Vagrant.configure("2") do |config|

   # VirtualBox
   config.vm.box = "trusty64"
   config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

   nodes.each do |temp|
        config.vm.define temp[:hostname] do |box|
           box.vm.hostname = temp[:hostname]
           box.vm.network :private_network, ip: "192.168.236.#{temp[:ip]}", :netmask => "255.255.255.0"
           box.vm.network :private_network, ip: "172.10.100.#{temp[:ip]}", :netmask => "255.255.255.0"
	   node_config("#{temp[:hostname]}",box.vm)
           #box.vm.provision :shell, :path => "#{temp[:hostname]}.sh"
           box.vm.provider :virtualbox do |config|
             config.customize ["modifyvm", :id, "--memory", 4096]
             config.customize ["modifyvm", :id, "--cpus",2 ]
           end
        end
   end
end


