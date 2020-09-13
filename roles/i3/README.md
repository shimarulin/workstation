# ansible-role-i3

> i3 window manager

### Compositing

- https://github.com/fennerm/flashfocus
- Picom fork with animations https://github.com/jonaburg/picom (see
  https://www.reddit.com/r/i3wm/comments/gro4nn/is_there_any_way_to_get_animations_like_this_with/)

### Workspace switching

- https://github.com/grenewode/i3switcher
  (https://www.reddit.com/r/i3wm/comments/7bb0qb/i3switcher_a_slightly_better_workspace_switcher/)
- https://github.com/SeerUK/i3x3
- https://github.com/infokiller/i3-workspace-groups
- https://www.reddit.com/r/i3wm/comments/8at5dv/i_wrote_an_expolike_script_for_i3/

- https://travisf.net/i3-wk-switcher
- https://github.com/un-def/i3-workspace-switcher
- https://github.com/tmfink/i3-wk-switch
- https://unix.stackexchange.com/questions/370622/workspace-sliding-animation-in-i3
- https://unix.stackexchange.com/questions/452617/i3wm-switching-to-workspaces-and-moving-container-to-same-workspace-map-to-di

## Config examples

- https://github.com/regolith-linux/regolith-i3-gaps-config
- https://github.com/abdes/arch-i3-polybar-dotfiles-autosetup
- https://github.com/levinit/i3wm-config

## Utils

- https://github.com/regolith-linux/i3-snapshot

## Libs

- https://github.com/regolith-linux/grelier

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
         - { role: i3, x: 42 }

## License

MIT
