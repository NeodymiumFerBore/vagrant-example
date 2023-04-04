# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

CLUSTER_CONFIG = File.expand_path("config.rb")
if File.exist?(CLUSTER_CONFIG)
  # Override defaults
  require CLUSTER_CONFIG
end

# Print the values of the variables
puts "Image:  #{IMAGE}
Memory: #{MEMORY}
CPUs:   #{CPUS}

MASTER_NODE_COUNT: #{MASTER_NODE_COUNT}
WORKER_NODE_COUNT: #{WORKER_NODE_COUNT}

IP_NW:  #{IP_NW}
MASTER_IP_START:   #{MASTER_IP_START}
WORKER_IP_START:   #{WORKER_IP_START}

INTERNAL_NET_NAME: #{INTERNAL_NET_NAME}
"

Vagrant.configure("2") do |config|
  # config.vm.box = "base"
  config.vm.box = IMAGE

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Provision Master Nodes
  (1..MASTER_NODE_COUNT).each do |i|
      config.vm.define "kubemaster0#{i}" do |node|
        # Name shown in the GUI
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubemaster0#{i}"
            vb.memory = MEMORY
            vb.cpus = CPUS
            vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
            
            #vmware_workstation stuff
            #vb.gui = true
        end
        node.vm.hostname = "kubemaster0#{i}"

        node.vm.network "private_network", ip: IP_NW + "#{MASTER_IP_START + i}",
          virtualbox__intnet: INTERNAL_NET_NAME
        node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"

        node.vm.provision "setup-dns", type: "shell", :path => "scripts/update-dns.sh"
        node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end
      end
  end

  # Provision Worker Nodes
  (1..WORKER_NODE_COUNT).each do |i|
    config.vm.define "kubenode0#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubenode0#{i}"
            vb.memory = MEMORY
            vb.cpus = CPUS
            vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
            
            #vmware_workstation stuff
            #vb.gui = true
        end
        node.vm.hostname = "kubenode0#{i}"
        node.vm.network "private_network", ip: IP_NW + "#{WORKER_IP_START + i}",
          virtualbox__intnet: INTERNAL_NET_NAME
        node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"

        node.vm.provision "setup-dns", type: "shell", :path => "scripts/update-dns.sh"
        node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end
    end
  end
end
