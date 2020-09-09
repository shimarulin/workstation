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
