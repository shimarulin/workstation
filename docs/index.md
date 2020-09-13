# Workstation

## Обзор

### Linux console (core)

- https://github.com/uobikiemukot/yaft

### Графическое окружение

- Display server (X Window System): _Xorg_
- Compositor: Picom (fork of _compton_) - https://github.com/regolith-linux/regolith-compositor-picom-glx
- Display manager (Экранный менеджер, менеджер входа): _LightDM_
- Window manager (Оконный менеджер): _i3_ (либо его форк i3-gaps)
- Screen locker (экран блокировки): _light-locker_
- Application launcher: rofi
- Panel: polybar, https://gitlab.com/vala-panel-project/vala-panel

Дистрибутивы:

- https://regolith-linux.org/ - позаимствовать некоторые сочетания клавиш и утилиты.

### Графический сервер

Можно выбирать между собственно _Xorg_ и различными реализациями _Wayland_. Последний пока не несет в себе достаточно
функционала: проприетарный драйвер Nvidia не поддерживается, открытый драйвер сильно проигрывает по производительности.
В результате на картах Nvidia _Wayland_ будет проигрывать, иногда значительно.

### Блокировка экрана

Для _LightDM_ и _i3_ можно использовать экран блокировки как на стороне менеджера входа
(_[light-locker](https://github.com/the-cavalry/light-locker)_), так и на стороне оконного менеджера
(_[i3lock](https://github.com/i3/i3lock)_). Есть еще скрипт https://github.com/meskarune/i3lock-fancy, он размывает фон,
используя для этого _imagemagick_.

Экран блокировки _light-locker_ выбран из-за своей функциональности и для обеспечения единого вида экранов блокировки и
входа.

### Фон рабочего стола

Для i3 частое решение - использование браузера изображений [feh](https://feh.finalrewind.org/). Для _feh_ (и _swaybg_)
также существует GTK+3 фронтенд [Azote](https://github.com/nwg-piotr/azote). _Azote_ также заменяет
https://github.com/dylanaraps/pywal. [Variety](https://github.com/varietywalls/variety) - еще один фронтенд,
поддерживающий _feh_. Кроме того, есть [i3-wpd](https://github.com/jomiq/i3-wpd) - простой демон обоев рабочего стола.

Подробнее про _feh_ можно почитать в https://wiki.archlinux.org/index.php/feh а также https://github.com/derf/feh.

### Композитинг

- https://github.com/regolith-linux/regolith-compositor-picom-glx

### Уведомления

- https://github.com/DaveDavenport/Rofication

## Справка

- https://github.com/regolith-linux/remontoire
