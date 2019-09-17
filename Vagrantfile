# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Requires installation of vagrant ignition
#   $ vagrant plugin install vagrant-ignition

COREOS_UPDATE_CHANNEL = 'alpha'
NUM_INSTANCES = 3

Vagrant.configure('2') do |config|
  config.vm.box = "coreos-#{COREOS_UPDATE_CHANNEL}"
  config.vm.box_url = "https://#{COREOS_UPDATE_CHANNEL}.release.core-os.net/amd64-usr/current/coreos_production_vagrant_virtualbox.json"
  config.ignition.enabled = true

  (1..NUM_INSTANCES).each do |i|
    vm_name = "core#{i}"
    config.vm.define vm_name do |conf|
      conf.vm.hostname = vm_name
      conf.ignition.hostname = vm_name
      conf.ignition.drive_name = 'drive' + i.to_s
      conf.ignition.path = load_file("ignition/etcd_dev_#{i}.ign")

      conf.vm.provider :virtualbox do |vb|
        conf.ignition.config_obj = vb
      end

      # expose etcd client interface
      conf.vm.network :forwarded_port, guest: 2379, host: 2379 + i

      # etcd peer network
      ip = "172.17.10.#{i + 1}"
      conf.vm.network :private_network, ip: ip
      conf.ignition.ip = ip
    end
  end
end

def load_file(path)
  File.join(File.dirname(__FILE__), path)
end
