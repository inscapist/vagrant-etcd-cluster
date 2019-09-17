# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install required plugins:
#   $ vagrant plugin install vagrant-ignition
#   $ vagrant plugin install vagrant-hosts

COREOS_UPDATE_CHANNEL = 'alpha'
NUM_INSTANCES = 3

Vagrant.configure('2') do |config|
  config.vm.box = "coreos-#{COREOS_UPDATE_CHANNEL}"
  config.vm.box_url = "https://#{COREOS_UPDATE_CHANNEL}.release.core-os.net/amd64-usr/current/coreos_production_vagrant_virtualbox.json"
  config.ignition.enabled = true

  (1..NUM_INSTANCES).each do |i|
    vm_name = "core#{i}"
    config.vm.define vm_name do |node|
      node.vm.hostname = vm_name
      node.ignition.hostname = vm_name
      node.ignition.drive_name = 'drive' + i.to_s
      node.ignition.path = load_file("ignition/etcd_dev_#{i}.ign")

      node.vm.provider :virtualbox do |vb|
        node.ignition.config_obj = vb
      end

      # expose etcd client interface
      node.vm.network :forwarded_port, guest: 2379, host: 2379 + i

      # etcd peer network
      ip = "172.17.10.#{i + 1}"
      node.vm.network :private_network, ip: ip
      node.ignition.ip = ip

      # Provides DNS based on hostnames (self and peers)
      node.vm.provision :hosts, sync_hosts: true
    end
  end
end

def load_file(path)
  File.join(File.dirname(__FILE__), path)
end
