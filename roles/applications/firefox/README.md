# Ansible Role "firefox"

> Firefox - Standalone web browser from mozilla.org (https://www.mozilla.org/firefox/)

## Requirements

- pipewire
- pipewire-jack (provided jack)
- noto-fonts (provided ttf-fonts)

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
    - firefox
```

```yaml
- name: Apply common configuration to all nodes # noqa: role-name[path]
  hosts: all
  roles:
    - role: firefox # noqa: role-name[path]
      tags:
        - laptop
        - desktop
```

## License

MIT
