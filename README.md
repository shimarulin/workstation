# Workstation

## Installation

The installation script inspired by [Arch Linux Install Script](https://picodotdev.github.io/alis/) and
[archfi](https://github.com/MatMoul/archfi). It used only to install the base system.

```
# # Start the system with lastest Arch Linux installation media
# loadkeys [keymap]
# curl https://raw.githubusercontent.com/shimarulin/workstation/master/get.sh | bash
# # or with URL shortener:
# # curl -sL https://git.io/JUGL3 | bash
# # curl -sL https://bit.ly/2QOooFJ | bash
# # curl -sL https://rb.gy/jm6qlg | bash
# # Edit install.conf and change variables values with your preferences
# vim install.conf
# # Start
# ./install.sh
```

## Ansible config

### Usage

Before run playbook you must setup common variables via `setup` script in this repository root:

```bash
# Setup Ansible variables
./setup --target vars
```

Run playbook on localhost

```bash
ansible-playbook playbook.yml
```

### Development

#### Tools

Documentation:

- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
  - [Ansible Module Index](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html)
  - [Vagrant Guide](https://docs.ansible.com/ansible/latest/scenario_guides/guide_vagrant.html)
- [Cookiecutter documentation](https://cookiecutter.readthedocs.io/en/latest/readme.html)
- [Argbash documentation](https://argbash.readthedocs.io/en/stable/)
- [Vagrant Documentation](https://www.vagrantup.com/docs/)

#### Getting started

Requirements:

- Python 3
- Ansible
- VirtualBox
- Vagrant
- Cookiecutter

Addition requirements:

- NodeJS
- Yarn

Also you should install `python-vagrant` and `cookiecutter` packages via pip:

```bash
# Install packages
pip3 install -U python-vagrant cookiecutter
```

and configure cookiecutter context with `setup` script in this repository root:

```bash
# Setup cookiecutter context
./setup --target cookiecutterrc
```

For enable Git Hook's to autoformatting files with [Prettier](https://prettier.io/) just install NodeJS packages with
Yarn:

```bash
yarn
```

#### Work with Ansible roles and variables

You can configure your variables with `setup` script:

```bash
# Setup Ansible variables
./setup --target vars
```

If you add variables manually, don't forget to change variables template in `templates/vars`. It will used for setup
variables before run playbook for setup target environment.

For create new role from template you can run `setup` with `--target role` or without args

```bash
# Create Ansible role
./setup --target role
# or
./setup
```

#### Create Vagrant box for test role from existing virtual machine

Create new virtual machine and install target distributive. In according to Vagrant conventions, create user `vagrant`
with password `vagrant`. This password don't need to run playbook and you can choice other if you need. After this it
need setup to use as Vagrant box.

Install and enable SSH server:

```bash
sudo pacman -Sy openssh
systemctl enable sshd.service
```

Add unsafe public key:

```bash
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
```

And add to end of file `/etc/sudoers` using the command `sudo visudo` (use `EDITOR=nvim sudo visudo` for change default
editor) these strings to connect to virtual machine via ssh without password:

```
# Vagrant required
vagrant ALL=(ALL) NOPASSWD: ALL
```

To make you own box you should run command

```bash
vagrant package --base ubuntu-19.10-desktop --output ubuntu-19.10-desktop.box
```

After this you can add you box:

```bash
vagrant box add ./ubuntu-19.10-desktop.box --name username/ubuntu-19.10-desktop
```

#### Use Vagrant to play tasks

```bash
# Start VM
vagrant up
# Replay tasks
vagrant provision
# Stop VM
vagrant halt
# Reset and restart VM
vagrant destroy && vagrant up
```

#### Delete default VM and box

In project root:

```bash
vagrant destroy
```

#### Watch DConf changes

```bash
dconf watch /
```

## Related projects

- [Arch Linux Install Script](https://picodotdev.github.io/alis/)
- [My Arch Setup](https://github.com/raphiz/my-arch-setup)
- [archfi](https://github.com/MatMoul/archfi)
- [Spark](https://github.com/pigmonkey/spark)
