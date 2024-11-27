# ansible-role-keyboard

> Keyboard configuration and tools

- https://wiki.archlinux.org/index.php/Extra_keyboard_keys\_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)

- https://www.reddit.com/r/bspwm/comments/8431ee/sxhkd_not_using_the_correct_keyboard_layout/

- https://github.com/baskerville/sxhkd/issues/63

- https://www.reddit.com/r/bspwm/comments/a1itud/sxhkd_with_keysym_number/eaqoind/

- https://habr.com/ru/post/222285/#comment_7586289

- https://habr.com/ru/post/486872/

- https://github.com/alols/xcape

- https://poweruser.guru/questions/644521/linux-mint-mate-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D1%83%D0%B9%D1%82%D0%B5-xkbcomp-%D0%B4%D0%BB%D1%8F-%D0%B7%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%BA%D0%B8-%D1%80%D0%B0%D1%81%D0%BA%D0%BB%D0%B0%D0%B4%D0%BA%D0%B8-%D0%BA%D0%BB%D0%B0%D0%B2%D0%B8%D0%B0%D1%82%D1%83%D1%80%D1%8B-%D0%BF%D1%80%D0%B8-%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA

- https://a3nm.net/blog/xkbcomp.html

- https://habr.com/ru/post/83223/

- http://rus-linux.net/MyLDP/x/xkb/examples.html

- https://wiki.archlinux.org/index.php/X_keyboard_extension

- https://wiki.archlinux.org/index.php/X_keyboard_extension#Caps_hjkl_as_vimlike_arrow_keys

- https://wiki.archlinux.org/index.php/X_keyboard_extension#Editing_the_layout

- https://unix.stackexchange.com/questions/317465/xkb-enable-a-led-for-specific-layout

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
     - { role: keyboard, x: 42 }
```

## License

MIT
