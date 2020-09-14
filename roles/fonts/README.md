# ansible-role-fonts

> Font collection and setting

- https://www.ubuntupit.com/15-best-linux-font-tools-and-how-to-install-linux-fonts-on-ubuntu/
- https://linuxhint.com/best_fonts_ubuntu_linux/
- https://www.webfx.com/blog/web-design/a-web-designers-guide-to-linux-fonts/

## Setup

### Emoji

- https://github.com/stove-panini/fontconfig-emoji

### Rendering

- https://blog.aktsbot.in/better-font-rendering-linux.html

## Editing

- https://birdfont.org/

---

extra/noto-fonts 20190926-4 Google Noto TTF fonts extra/noto-fonts-cjk 20190409-2 Google Noto CJK fonts
extra/noto-fonts-emoji 20200720-1 Google Noto emoji fonts extra/noto-fonts-extra 20190926-4 Google Noto TTF fonts -
additional variants

extra/xorg-font-util 1.3.2-2 (xorg-fonts xorg) X.Org font utilities extra/xorg-fonts-100dpi 1.0.3-7 (xorg) X.org 100dpi
fonts extra/xorg-fonts-75dpi 1.0.3-7 (xorg) X.org 75dpi fonts extra/xorg-fonts-alias-100dpi 1.0.4-1 X.org font alias
files - 100dpi font familiy extra/xorg-fonts-alias-75dpi 1.0.4-1 X.org font alias files - 75dpi font familiy
extra/xorg-fonts-alias-cyrillic 1.0.4-1 X.org font alias files - cyrillic font familiy extra/xorg-fonts-alias-misc
1.0.4-1 X.org font alias files - misc font familiy extra/xorg-fonts-cyrillic 1.0.3-6 X.org cyrillic fonts
extra/xorg-fonts-encodings 1.0.5-2 (xorg-fonts xorg) [установлен] X.org font encoding files extra/xorg-fonts-misc
1.0.3-10 X.org misc fonts extra/xorg-fonts-type1 7.7-6 X.org Type1 fonts extra/xorg-mkfontscale 1.2.1-2 (xorg-apps xorg)
Create an index of scalable font files for X extra/xorg-xfd 1.1.3-2 Displays all the characters in a font using either
the X11 core protocol or libXft2 extra/xorg-xfontsel 1.0.6-3 Point and click selection of X11 font names
extra/xorg-xlsfonts 1.0.6-3 List available X fonts

community/powerline-fonts 2.8.1-1 patched fonts for powerline

community/ttf-nerd-fonts-symbols 2.1.0+36+gd0bf73a1-2 High number of extra glyphs from popular 'iconic fonts' (2048-em)
community/ttf-nerd-fonts-symbols-mono 2.1.0+36+gd0bf73a1-2 High number of extra glyphs from popular 'iconic fonts'
(1000-em) community/ttf-proggy-clean 1.1.5-2 Monospaced fonts for programming

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
         - { role: fonts, x: 42 }

## License

MIT
