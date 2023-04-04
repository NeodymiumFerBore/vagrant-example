# vagrant-example

Random Vagrant example. Deploy one or more VM called `kubemaster0${x}`, and one or more VM called `kubenode0${x}`.

Actually configured to use VirtualBox internal network adapter + NAT adapter with port forwarding.
If you want to use Host-Only adapter, then adapt `Vagrantfile`.

## How to use

Customise `config.rb`.
