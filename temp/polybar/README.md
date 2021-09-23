# ansible-role-polybar

> A fast and easy-to-use status bar

## Docs

- https://wiki.archlinux.org/index.php/Polybar_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
- https://github.com/polybar/polybar

## Config examples

- https://github.com/abdes/arch-i3-polybar-dotfiles-autosetup
- https://gitlab.com/dwt1/dotfiles/blob/master/.config/polybar/config

## Modules

- https://github.com/rosenpin/i3-agenda
- https://github.com/kantord/i3-gnome-pomodoro
- https://github.com/haideralipunjabi/polybar-kdeconnect
- https://github.com/manilarome/rofi-spotlight
- https://github.com/ClydeDroid/rofi-bluetooth
- https://github.com/sumnerevans/menu-calc
- https://askubuntu.com/questions/1073059/adding-network-selection-clickable-menu-in-polybar

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
         - { role: polybar, x: 42 }

## License

MIT
