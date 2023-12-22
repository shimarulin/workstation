# Ansible Role "adobe_source"

> Adobe Source fonts family

- [adobe-source-code-pro-fonts](https://archlinux.org/packages/extra/any/adobe-source-code-pro-fonts/): Monospaced font
  family for user interface and coding environments https://adobe-fonts.github.io/source-code-pro/
- [adobe-source-sans-fonts](https://archlinux.org/packages/extra/any/adobe-source-sans-fonts/): Sans-serif font family
  for user interface environments https://adobe-fonts.github.io/source-sans/
- [adobe-source-serif-fonts](https://archlinux.org/packages/extra/any/adobe-source-serif-fonts/): Serif typeface
  designed to complement Source Sans https://adobe-fonts.github.io/source-serif/

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

```yaml
- name: Apply common configuration to all nodes # noqa: role-name[path]
  hosts: all
  roles:
    - adobe-source
```

```yaml
- name: Apply common configuration to all nodes # noqa: role-name[path]
  hosts: all
  roles:
    - role: adobe-source # noqa: role-name[path]
      tags:
        - laptop
        - desktop
```

## License

MIT
