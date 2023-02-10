# ansible-role-package-management-setup

> your description

```shell
sudo pacman -Syu # synchronize the repository databases and update the system's packages, excluding "local" packages that are not in the configured repositories
sudo pacman -S <package_name1> <package_name2> # install a single package or list of packages
sudo pacman -Rs <package_name> # remove a package and its dependencies which are not required by any other installed package
```

## Requirements

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the
role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

## Role Variables

A description of the settable variables for this role should go here, including any variables that are in
defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables
that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as
well.

## Dependencies

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set
for other roles, or variables that are used from other roles.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for
users too:

    - hosts: servers
      roles:
         - { role: package-management-setup, x: 42 }

## License

MIT
