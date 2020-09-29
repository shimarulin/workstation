# Workstation

## Distro

- https://regolith-linux.org/
- https://instantos.io/
- https://archcraft-os.github.io/features.html
- https://ctlos.github.io/

## Обзор

Интересные дистрибутивы:

- https://ctlos.github.io/wiki - установка и русификация
- https://regolith-linux.org/ - i3 и сочетания клавиш
- https://instantos.io/ - сочетания клавиш, композитный менеджер и эффекты

### Linux console (core)

- https://github.com/uobikiemukot/yaft

### Графическое окружение

- Display server (X Window System): _Xorg_
- Compositor: Picom (fork of _compton_) - https://github.com/regolith-linux/regolith-compositor-picom-glx
- Display manager (Экранный менеджер, менеджер входа): _LightDM_
- Window manager (Оконный менеджер): _i3_ (либо его форк i3-gaps)
- Screen locker (экран блокировки): _light-locker_
- Application launcher: rofi
- Panel: polybar, https://gitlab.com/vala-panel-project/vala-panel, https://github.com/geommer/yabar

Дистрибутивы:

- https://regolith-linux.org/ - позаимствовать некоторые сочетания клавиш и утилиты.

---

- https://github.com/un-def/i3-workspace-switcher

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

Динамическая смена обоев https://github.com/xyproto/wallutils

### Композитинг

Та самая штука, которая обеспечивает прозрачность окон, анимации и пр. Краткая история standalone композиторов в Linux:
xcompmgr -> xcompmgr-dana -> Compton -> Picom. В один из форков compton-а https://github.com/BlackCapCoder/compton были
внесены изменения, позволяющие анимировать изменения окон. Так как Picom является форком Compton, эти изменения
перекочевали, а может быть и были написаны с нуля, в форк (а точнее форк форка) https://github.com/jonaburg/picom.
Информация взята из обсуждений на реддите
https://www.reddit.com/r/i3wm/comments/gro4nn/is_there_any_way_to_get_animations_like_this_with/

Настройки для оригинального Picom:

- https://github.com/regolith-linux/regolith-compositor-picom-glx

### Panel:

- https://github.com/geommer/yabar,
- polybar,
- https://gitlab.com/vala-panel-project/vala-panel

### Уведомления

[Linux Notification Center](https://github.com/phuhl/linux_notification_center) выглядит достаточно современно. В
качестве альтернативы можно рассмотреть https://github.com/DaveDavenport/Rofication и https://dunst-project.org/

### Буфер обмена

- В сочетании с rofi - https://github.com/erebe/greenclip, https://github.com/cdown/clipmenu/
- В сочетании с i3 - https://github.com/mrichar1/clipster
- https://hluk.github.io/CopyQ/
- https://github.com/pvanek/qlipper/

### Сочетания клавиш

Желательно, чтобы сочетания клавиш не зависели от оконного менеджера.

- https://github.com/baskerville/sxhkd
- https://www.reddit.com/r/i3wm/comments/is2x7a/use_sxhkd_along_with_i3/

В качестве основы для разработки собственных сочетаний клавиш в первую очередь следует рассмотреть оригинальные
сочетания i3. Кроме того, сочетания, принятые в https://github.com/regolith-linux. Одним из уникальных приложений для
это этого дистрибутива является https://github.com/regolith-linux/remontoire, который отображает клавиатурные сочетания
(Cheat sheet). Еще - https://instantos.io/

Отобразить нажатые клавиши на экране может https://gitlab.com/screenkey/screenkey

[Evdoublebind](https://github.com/exrok/evdoublebind) через evdev предоставляет ключи двойного связывания: ключи,
которые перегружены функциональностью, действующей как модификатор при удерживании, но другая клавиша при нажатии
отдельно.

- https://vickychijwani.me/blazing-fast-application-switching-in-linux/
- https://i64.dev/evdoublebind-introduction/
- https://help.ubuntu.com/stable/ubuntu-help/shell-notifications.html.en

### Запуск приложений

- https://github.com/davatorium/rofi
- https://github.com/johanmalm/jgmenu - тут почитать про интеграцию с polybar
- https://github.com/Tomas-M/xlunch
- https://github.com/nwg-piotr/sgtk-menu

Некоторые лаунчеры:

- https://github.com/MarkHedleyJones/dmenu-extended
- https://github.com/buster/rrun
- https://github.com/emgram769/lighthouse
- https://github.com/sgtpep/pmenu
- https://github.com/instantOS/instantMENU
- https://github.com/PonasKovas/rlaunch
- https://github.com/kokoko3k/higgins
- https://github.com/enkore/j4-dmenu-desktop
- https://github.com/echo-devim/slingswarm
- https://github.com/wvffle/waffy

Дропдаун окно в i3 (quake mode) - https://i64.dev/i3dropdown-animated-drop-down/ (https://gitlab.com/exrok/i3dropdown).
Для терминала - https://github.com/lbonn/i3-quickterm

### Приложения по умолчению

- https://github.com/chmln/handlr

### Проверка обновлений

- https://jjacky.com/kalu/

### Интеграции

### Аудио

Переключение входов и выходов звука - https://github.com/yktoo/indicator-sound-switcher.

### Воспроизведение аудио

- Music Player Daemon (MPD) - широко распространен, активно разрабатывается, легковесный и интегрируется со многими
  приложениями, имеет различные фронтенды
- [Ymuse](https://github.com/yktoo/ymuse) - фронтенд к MPD
- [Lollypop](https://gitlab.gnome.org/World/lollypop) - плейер
- Shortwave - интернет-радио
- [Cozy](https://github.com/geigi/cozy) - audio books

### Запись аудио

https://wiki.gnome.org/Apps/SoundRecorder

### Запись видео

- https://github.com/amikha1lov/RecApp
- TODO: more CLI tools

### Воспроизведение видео

- https://mpv.io/ + https://github.com/celluloid-player/celluloid

### Edit Video

- https://gitlab.gnome.org/YaLTeR/video-trimmer

### Screenshot

- https://flameshot.js.org/#/
- TODO: more CLI tools

### Book and docs reading

- https://johnfactotum.github.io/foliate/

### EMail?

- https://wiki.gnome.org/Apps/Geary (https://gitlab.gnome.org/GNOME/geary)

### RSS

- https://gitlab.gnome.org/World/gfeeds (https://gabmus.gitlab.io/gnome-feeds/)
- https://gitlab.com/news-flash/news_flash_gtk

### Tasks

- https://github.com/getting-things-gnome/gtg/ (https://wiki.gnome.org/Apps/GTG)
- https://gitlab.com/jmiskinis/gnome-shell-extension-task-widget/
- https://github.com/johannesjo/super-productivity

### Vim

- https://github.com/Badacadabra/Vimpressionist
- https://github.com/Badacadabra/vim-archery
- https://github.com/jwilm/i3-vim-focus

## Others

- https://github.com/tortious/Master-Scripting-Repo

### Nautilus

- https://www.omgubuntu.co.uk/2020/07/open-folder-in-terminal-ubuntu-plugin

### Terminal

- https://arcolinuxd.com/10-why-are-we-using-urxvt-in-bspwm-instead-of-termite/
