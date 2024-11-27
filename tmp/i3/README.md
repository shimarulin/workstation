# ansible-role-i3

> i3 window manager

## Development

### Config syntax highlighting

- Vim - https://github.com/mboughaba/i3config.vim
- VSC - https://github.com/dcasella/i3wm-syntax
- Atom - https://github.com/taylon/language-i3wm
- Sublime Text - https://github.com/skk/i3wm-sublime

#### JetBrains IDE's custom type

Line comment: `#`

Keywords 1

```
assign
bindcode
bindsym
client.background
client.focused
client.focused
client.focused_inactive
client.placeholder
client.unfocused
client.urgent
default_border
default_floating_border
default_orientation
exec
exec_always
floating_maximum_size
floating_minimum_size
floating_modifier
focus_follows_mouse
focus_on_window_activation
focus_wrapping
font
for_window
force_display_urgency_hint
force_xinerama
hide_edge_borders
ipc-socket
mode
mouse_warping
no_focus
popup_during_fullscreen
set
show_marks
title_align
workspace_auto_back_and_forth
workspace_layout
```

Keywords 2

```
$mod
Shift
```

## Notes

`i3-sensible-terminal` - launches $TERMINAL with fallbacks. $TERMINAL (this is a non-standard variable). See
https://wiki.archlinux.org/index.php/Environment_variables

### Articles

- https://ersi.vivaldi.net/2018/08/19/qtile-versus-i3wm-still-looking-for-the-perfect-desktop/

- https://samsaffron.com/archive/2019/04/09/my-i3-window-manager-setup

- https://fedoramagazine.org/getting-started-i3-window-manager/

- https://fedoramagazine.org/using-i3-with-multiple-monitors/

- https://opensource.com/article/18/8/i3-tiling-window-manager

- https://i3wm.org/docs/userguide.html

- https://dzone.com/articles/archlinux-tutorial-part-3-i3-configuration-and-ope

- https://unix.stackexchange.com/questions/452617/i3wm-switching-to-workspaces-and-moving-container-to-same-workspace-map-to-di

- https://www.reddit.com/r/i3wm/comments/ipsgdr/rofi_freezes_i3/

- https://www.reddit.com/r/i3wm/comments/7bb0qb/i3switcher_a_slightly_better_workspace_switcher/

- https://www.reddit.com/r/i3wm/comments/8at5dv/i_wrote_an_expolike_script_for_i3/

- https://www.reddit.com/r/i3wm/comments/9x2l64/display_preview_of_all_workspaces/

- https://github.com/mboughaba/i3config.vim

- https://github.com/burik666/yagostatus

### Multi monitor

- https://github.com/chmln/enact
- https://github.com/lpicanco/i3-autodisplay

### Compositing

- https://github.com/fennerm/flashfocus
- Picom fork with animations https://github.com/jonaburg/picom (see
  https://www.reddit.com/r/i3wm/comments/gro4nn/is_there_any_way_to_get_animations_like_this_with/)

### Style

- https://github.com/altdesktop/i3-style

### Window switching

- https://github.com/svenstaro/wmfocus

### Screenlock

- https://gitlab.com/jD91mZM2/xidlehook - runner

### Workspace switching

- https://github.com/grenewode/i3switcher
  (https://www.reddit.com/r/i3wm/comments/7bb0qb/i3switcher_a_slightly_better_workspace_switcher/)

- https://github.com/SeerUK/i3x3

- https://github.com/infokiller/i3-workspace-groups

- https://www.reddit.com/r/i3wm/comments/8at5dv/i_wrote_an_expolike_script_for_i3/

- https://github.com/infokiller/i3-workspace-groups

- https://www.reddit.com/r/i3wm/comments/a6s8kp/do_i3_workspaces_have_to_be_linear/

- https://github.com/Chimrod/i3_workspaces

- https://travisf.net/i3-wk-switcher

- https://github.com/un-def/i3-workspace-switcher

- https://github.com/tmfink/i3-wk-switch

- https://unix.stackexchange.com/questions/370622/workspace-sliding-animation-in-i3

- https://unix.stackexchange.com/questions/452617/i3wm-switching-to-workspaces-and-moving-container-to-same-workspace-map-to-di

#### Dynamic workspaces

- https://github.com/kalbasit/i3-dynamic-workspaces
- https://github.com/mbaynton/i3-workspace-hinting

## Config examples

- https://github.com/regolith-linux/regolith-i3-gaps-config
- https://github.com/abdes/arch-i3-polybar-dotfiles-autosetup
- https://github.com/levinit/i3wm-config
- https://github.com/addy-dclxvi/i3-starterpack
- https://github.com/addy-dclxvi/almighty-dotfiles
- https://www.deviantart.com/addy-dclxvi/art/Take-Off-708842048

## Utils

- https://github.com/regolith-linux/i3-snapshot
- https://github.com/altdesktop/i3ipc-python/blob/master/examples/i3-cycle-focus.py
- https://github.com/svenstaro/wmfocus
- https://github.com/cornerman/i3-easyfocus
- https://github.com/OliverUv/quickswitch-for-i3/

## Libs

- https://github.com/regolith-linux/grelier

## Troubleshooting

### JetBrains IDE's

- https://stackoverflow.com/questions/53957831/intellij-in-blocked-mode-when-window-comes-into-focus
- https://efod.se/pycharm-idea-i3wm/

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

```
- hosts: servers
  roles:
     - { role: i3, x: 42 }
```

## License

MIT
