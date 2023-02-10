## Update notify

```
# TODO: Use SystemD (timer+service+script) and libnotify for universal update notifier with AUR support
# If you use the default "checkupdates" way you will need to install "pacman-contrib".

# See
# - https://github.com/fellchase/update-notification
# - https://gitlab.com/artafinde/aarchup/-/tree/master/extra
# - https://github.com/Chrysostomus/update-notifier
# - https://gitlab.manjaro.org/applications/manjaro-system-ng/-/tree/master
# - https://jjacky.com/kalu/
# - https://gist.github.com/logarytm/575263a76d22f29ef721f40b2785d5c8
# - https://bbs.archlinux.org/viewtopic.php?id=260353
```

## TTY terminal

issues:

- 256 colors

### 256 colors

Используйте `fbterm` - https://unix.stackexchange.com/a/111667 . Проблема: не удалось найти `fbterm`. Альтернативы:

- https://github.com/uobikiemukot/yaft
- https://wiki.archlinux.org/index.php/Uvesafb

## Fonts

Bitmap fonts (tty)

- https://wiki.archlinux.org/index.php/fonts#Bitmap
- http://terminus-font.sourceforge.net/
- https://tobiasjung.name/profont/

Monospace fonts

- https://www.levien.com/type/myfonts/inconsolata.html
- https://github.com/source-foundry/Hack
- https://github.com/tonsky/FiraCode
- https://github.com/i-tu/Hasklig
- https://typeof.net/Iosevka/

## ZSH

- https://habr.com/ru/post/425137

## Замена символов, введенных в другой раскладке

https://habr.com/ru/post/425137/#comment_19184417

```bash
xclip -selection clipboard -o | perl -CS -Mutf8 -pe "tr/\`&qwertyuiop[]asdfghjkl;'zxcvbnm,.\/~QWERTYUIOP{}ASDFGHJKL;'ZXCVBNM,.\/ё?йцукенгшщзхъфывапролджэячсмитьбю.ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ./ё?йцукенгшщзхъфывапролджэячсмитьбю.ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ.\`&qwertyuiop[]asdfghjkl;'zxcvbnm,.\/~QWERTYUIOP{}]ASDFGHJKL;'ZXCVBNM,./;" | xclip -selection clipboard -i
```

или

```bash
fixlayout() {
  en="qwertyuiop\[]asdfghjkl;'\zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"|ZXCVBNM<>\@№%%^&*"
  ru="йцукенгшщз\хъфывапролджэёячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖ\ЭЁЯЧСМИТЬБЮ\"#$:,.;"
  pbpaste | sed y=$en$ru=$ru$en= | pbcopy
}
```
