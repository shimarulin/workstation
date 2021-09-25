# Arch workstation config

## Installation

### Install dependencies per user (recommended)

```shell
# Upgrade your system
sudo pacman -Syu
# Install dependencies
sudo pacman -S git python
python -m ensurepip --upgrade --user
ln -s pip3 ~/.local/bin/pip
python -m pip install --user ansible
pip install --user cookiecutter
```

### Install dependencies globally

```shell
# Upgrade your system
sudo pacman -Syu
# Install dependencies
sudo pacman -S git python python-pip ansible
sudo pip install cookiecutter
```

### Get configuration

```shell
# Create config dir
mkdir ~/.config && cd "$_"
# Clone configuration
git clone https://github.com/shimarulin/workstation.git
cd workstation
ansible-galaxy install -r requirements.yml
```

## Usage

Before run playbook you must setup common variables via `setup` script in this repository root:

```bash
# Setup Ansible variables
./setup --target vars
```

Run playbook on localhost

```bash
ansible-playbook playbook.yml
```

## Development

### Tools

Documentation:

- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
  - [Ansible Module Index](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html)
  - [Vagrant Guide](https://docs.ansible.com/ansible/latest/scenario_guides/guide_vagrant.html)
- [Cookiecutter documentation](https://cookiecutter.readthedocs.io/en/latest/readme.html)
- [Argbash documentation](https://argbash.readthedocs.io/en/stable/)
- [Vagrant Documentation](https://www.vagrantup.com/docs/)

### Articles

- [Using Ansible templates to maintain partial file blocks](https://garthkerr.com/using-ansible-template-for-partial-file-block/)

### Getting started

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
# or
pip install -U python-vagrant cookiecutter
```

For enable Git Hook's to autoformatting files with [Prettier](https://prettier.io/) just install NodeJS packages with
Yarn:

```bash
yarn
```

### Configure Ansible variables

```bash
# Setup Ansible variables
cookiecutter -f templates/vars
```

If you add variables manually, don't forget to change variables template in `templates/vars`. It will used for setup
variables before run playbook for setup target environment.

### Create Ansible role

```bash
# Create Ansible role
cookiecutter --output-dir roles templates/role
```

### Create Vagrant box for test role from existing virtual machine

Create new virtual machine and install target distributive. In according to Vagrant conventions, create user `vagrant`
with password `vagrant`. This password don't need to run playbook and you can choice other if you need. After this it
need setup to use as Vagrant box.

Install and enable SSH server:

```bash
sudo pacman -Sy openssh
sudo systemctl enable sshd.service
```

Add unsafe public key:

```bash
mkdir -pm 700 ~/.ssh
curl -L https://git.io/v47gO -o ~/.ssh/authorized_keys
# or
# curl -L https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -o ~/.ssh/authorized_keys
# or
# wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
```

And add to end of file `/etc/sudoers` using the command `sudo visudo` (use `sudo EDITOR=nvim visudo` for change default
editor) these strings to connect to virtual machine via ssh without password:

```
# Vagrant required
vagrant ALL=(ALL) NOPASSWD: ALL
```

To make you own box you should run command

```bash
# VirtualBox VM name: Arch
vagrant package --base Arch --output arch.box
```

After this you can add you box:

```bash
vagrant box add ./arch.box --name vagrant/arch
```

### Use Vagrant to play tasks

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

### Delete default VM and box

In project root:

```bash
vagrant destroy
```

### Watch DConf changes

```bash
dconf watch /
```

## Related projects

- [Arch Linux Install Script](https://picodotdev.github.io/alis/)
- [My Arch Setup](https://github.com/raphiz/my-arch-setup)
- [archfi](https://github.com/MatMoul/archfi)
- [Spark](https://github.com/pigmonkey/spark)
- [arch-install](https://github.com/wrzlbrmft/arch-install)
- [krushn-arch](https://github.com/krushndayshmookh/krushn-arch)

## Docs and articles

- https://wiki.archlinux.org/
- https://ctlos.github.io/wiki
- https://regolith-linux.org/
- https://instantos.io/
- https://pikedom.com/install-ansible-on-arch-linux/
- https://blackarch.ru/?p=198
- https://computingforgeeks.com/arch-linux-easy-and-fast-installation-with-archfi-installer/
- https://disconnected.systems/blog/archlinux-installer/#setting-variables-and-collecting-user-input
