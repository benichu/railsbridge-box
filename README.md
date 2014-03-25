railsbridge-box
===============

[Packer](http://www.packer.io/) files used for RailsbridgeMTL development workstations

## Prerequisites

- [Packer 1.5+](http://www.packer.io/)
- [VirtualBox 4.3+](https://www.virtualbox.org/wiki/Downloads)
- [iso/ubuntu-13.10-server-amd64.iso](http://www.ubuntu.com/download/server)
- [Vagrant 1.3.5+](http://downloads.vagrantup.com/)

## Building a brand new virtual box

Customize your environment by editing some of the parameters in those files:

- Box settings: `./packer.json`
- Development environment: `./scripts/setup.sh`

Start building your virtual machine:

```bash
$ ./create_box
```

Wait (quite a long time...) and you can test your brand new vagrant box:

```bash
$ cd railsbridge-box
$ vagrant destroy
$ vagrant up
$ vagrant ssh
```

You can then distribute your vagrant box build: `railsbridge-iso_virtualbox.box`

## Vagrantfile

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "railsbridge_mtl_201304"
  config.vm.box_url = "http://.../railsbridge-iso_virtualbox.box"
  config.vm.box_download_checksum = "..."
  config.vm.box_download_checksum_type = "" # supported "md5", "sha1", and "sha256".

  config.vm.network :forwarded_port, guest: 3000, host: 3000
end
```

## License

See ./LICENSE
