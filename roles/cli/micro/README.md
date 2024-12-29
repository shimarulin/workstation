# Ansible Role "micro"

> 'micro' - A modern and intuitive terminal-based text editor

## Keybindings

All default key bindings are contained in the file https://github.com/zyedidia/micro/blob/master/internal/action/defaults_other.go.

### Multiple cursors

| Key            | Description of function                                                                      | Mod |
|----------------|----------------------------------------------------------------------------------------------|-----|
| Alt-n          | Create new multiple cursor from selection (will select current word if no current selection) |     |
| Alt-Shift-Up   | Spawn a new cursor on the line above the current one                                         |     |
| Alt-Shift-Down | Spawn a new cursor on the line below the current one                                         |     |
| Alt-p          | Remove latest multiple cursor                                                                |     |
| Alt-c          | Remove all multiple cursors (cancel)                                                         |     |
| Alt-x          | Skip multiple cursor selection                                                               | ️   |
| Alt-m          | Spawn a new cursor at the beginning of every line in the current selection                   |     |
| Alt-MouseLeft  | Place a multiple cursor at any location                                                      | ✔   |


---

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
    - micro
```

```yaml
- name: Apply common configuration to all nodes # noqa: role-name[path]
  hosts: all
  roles:
    - role: micro # noqa: role-name[path]
      tags:
        - laptop
        - desktop
```

## License

MIT
