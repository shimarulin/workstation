# Arch workstation config

## Installation

```shell
# Download https://raw.githubusercontent.com/shimarulin/workstation/main/get
# with Curl
curl -L https://git.io/JPBef --output get
# or Wget
wget https://git.io/JPBef -O get
# Mark the file as executable
chmod +x get
# Run
./get
```

See https://github.com/shimarulin/workstation/blob/main/get for details.

## Usage

> :warning: Before starting the configuration, make sure that the variables in the `group_vars/all` file in the
> repository root are defined. If not, you can set up it via cookiecutter template:
>
> ```bash
> # Setup Ansible variables
> cd ~/.config/localhost && python -m cookiecutter -f templates/vars
> ```

Run playbook on localhost with common configuration

```bash
cd ~/.config/localhost && ansible-playbook playbook.yml
```

Run playbook on localhost for desktop setup

```bash
cd ~/.config/localhost && ansible-playbook playbook.yml --tags "desktop"
```

Run playbook on localhost for laptop setup

```bash
cd ~/.config/localhost && ansible-playbook playbook.yml --tags "laptop"
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

### Getting started

Requirements:

- Python 3
- Ansible
- VirtualBox
- Vagrant
- Cookiecutter ([Copier](https://github.com/copier-org/copier))

Addition requirements:

- NodeJS
- Yarn

Also, you should install `python-vagrant` and `cookiecutter`(`copier`) packages via pip:

```bash
# Install packages
pip install -U python-vagrant cookiecutter
```

```bash
# Install packages
pip install -U python-vagrant copier
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

```bash
# Setup Ansible variables
copier tools/templates/template_ansible_vars ./

# or
# ./tools/scripts/setvars.sh
```

If you add variables manually, don't forget to change variables template in `templates/vars`. It will be used for setup
variables before run playbook for setup target environment.

### Create Ansible role

```bash
# Create Ansible role
cookiecutter --output-dir roles templates/role
```

```bash
# Create Ansible role
copier tools/templates/template_ansible_role roles

# or
# ./tools/scripts/mkrole.sh
```

### Run playbook on VirtualBox VM directly with shared folders

#### Setup VM

VM Settings -> Shared Folders -> Adds new shared folder:

- Folder Path: /home/username/path-to-project/workstation
- Folder Name: workstation
- Mount point: /home/username/workstation
- Auto mount: enable

#### Setup guest OS

```shell
sudo pacman -Sy virtualbox-guest-utils-nox
sudo systemctl enable vboxservice.service
sudo gpasswd -a user vboxsf
sudo reboot
```

#### Install Ansible and run playbook

```shell
cd ~/workstation && ./get
```

### Run playbook on VirtualBox VM with Vagrant

#### Create Vagrant box for test role from existing virtual machine

Create new virtual machine and install target distributive. In according to Vagrant conventions, create user `vagrant`
with password `vagrant`. This password don't need to run playbook, and you can choose other if you need. After this it
needs setup to use as Vagrant box.

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
vagrant ALL=(ALL:ALL) NOPASSWD: ALL
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

Connect to virtual machine by ssh

```shell
vagrant ssh
```

#### Delete default VM and box

In project root:

```bash
vagrant destroy
```

#### Setup VirtualBox Guest Addition

```shell
pacman -S virtualbox-guest-utils
sudo systemctl enable vboxservice
```
