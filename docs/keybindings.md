# Сочетания клавиш

Todo:

- [ ] составить список клавиатурных комбинаций
  - https://i3wm.org/docs/refcard.html
  - https://regolith-linux.org/docs/reference/keybindings/
  - https://github.com/regolith-linux/regolith-i3-gaps-config/blob/master/config
  - https://archcraft-os.github.io/features.html
  - https://material-shell.com/#hotkeys
- [ ] рассмотреть возможности двойного связывания https://github.com/exrok/evdoublebind
- [x] использование https://github.com/baskerville/sxhkd
  - https://medium.com/@jonas.elan/create-key-binding-for-media-control-on-linux-like-spotify-bdd60599145e
  - https://my-take-on.tech/2020/07/03/some-tricks-for-sxhkd-and-bspwm/#closelock-screen
  - https://www.reddit.com/r/bspwm/comments/8431ee/sxhkd_not_using_the_correct_keyboard_layout/
- [ ] клавиатурные сочетания для работы с выделенным текстом:
  - поменять символы введенные в другой раскладке
  - toggle case
- [x] HotKey Helper - использование https://github.com/regolith-linux/remontoire и интеграция с sxhkd
  > Remontoire просто парсит комментарии. Нет разницы, чьи это будут конфиги. Это дополнительная работа по их внесению и
  > актуализации. Возможно, стоит рассмотреть парсеры, которые будут собирать информацию из файлов конфигурации и
  > создавать комментарии для Remontoire автоматически.
- [ ] Подсветка задействованных клавиш https://github.com/RasmusLindroth/i3keys
- [ ] HotKey Helper - https://github.com/fiskhest/rhkhm - sxhkd + rofi
- [ ]

Использовать для биндинга:

- i3
- sxhkd
- оба

### XKB (X keyboard extension)

- https://wiki.archlinux.org/index.php/Xorg_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)/Keyboard_configuration_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
- https://wiki.archlinux.org/index.php/X_keyboard_extension
- https://wiki.gentoo.org/wiki/Keyboard_layout_switching
- https://medium.com/@damko/a-simple-humble-but-comprehensive-guide-to-xkb-for-linux-6f1ad5e13450
- http://www.linuxlib.ru/Linux/xkb/index.html
- http://xgu.ru/wiki/xkb
- https://subscription.packtpub.com/book/networking_and_servers/9781849519724/1/ch01lvl1sec17/configuring-gui-using-xorg-should-know

### Навигация

- [vim like keybindings for i3wm](https://github.com/michaelmrose/vi3)
- https://vitiral.github.io/linux/2015/10/30/30-i3-vim-mode.html
- https://medium.com/usevim/hjkl-and-touch-typing-92bfb75e0818
- http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/

### Reference Card

| Key Binding                                    | Action            | Comment                                                    |
| ---------------------------------------------- | ----------------- | ---------------------------------------------------------- |
| _Launch Application_                           |                   |                                                            |
| <kbd>Super</kbd>+<kbd>Enter</kbd>              | run terminal      |                                                            |
| <kbd>Super</kbd>+<kbd>Space</kbd>              | run app menu      |                                                            |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>?</kbd> | run hotkey helper |                                                            |
|                                                |                   |                                                            |
| _Navigation_                                   |                   |                                                            |
| <kbd>Super</kbd>+<kbd>h</kbd>                  |                   | Vim like, in i3 (<kbd>Super</kbd>+<kbd>j</kbd>) by default |
| <kbd>Super</kbd>+<kbd>j</kbd>                  |                   | Vim like, in i3 (<kbd>Super</kbd>+<kbd>k</kbd>) by default |
| <kbd>Super</kbd>+<kbd>k</kbd>                  |                   | Vim like, in i3 (<kbd>Super</kbd>+<kbd>l</kbd>) by default |
| <kbd>Super</kbd>+<kbd>l</kbd>                  |                   | Vim like, in i3 (<kbd>Super</kbd>+<kbd>;</kbd>) by default |
