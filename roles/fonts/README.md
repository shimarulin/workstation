# Font collection

## Bitmap fonts for Linux Console

### [Terminus](https://terminus-font.sourceforge.net/)

Monospace bitmap font (for X11 and Linux console)

```yaml
dependencies:
  - role: "fonts/collection/terminus_font"
```

## Monospaced fonts

## Other

```yaml
# TODO:
# - http://mplus-fonts.osdn.jp/about-en.html
# - http://www.latofonts.com/
fonts_packages:
  # Fonts
  ## Adobe Source family
  - adobe-source-code-pro-fonts # [installed]
  - adobe-source-sans-pro-fonts
  - adobe-source-serif-pro-fonts
  ## Noto
  - noto-fonts
  - noto-fonts-emoji
  #  - noto-fonts-extra
  ## Fira
  - ttf-fira-sans
  - ttf-fira-code
  ## Monospace fonts for programmers
  #- ttf-inconsolata
  - ttf-fantasque-sans-mono # https://github.com/belluzj/fantasque-sans
  - ttf-hack
  ## Others
  - cantarell-fonts # [installed]
  - ttf-bitstream-vera
  - ttf-dejavu
  - ttf-liberation
  - ttf-opensans
  - ttf-roboto

  # Tools
  - fontconfig # [installed]
  ## - fontconfig-docs

fonts_aur_packages:
  - ttf-iosevka
  - ttf-inconsolata-lgc-git # https://github.com/DeLaGuardo/Inconsolata-LGC
  #- ttf-inconsolata-lgc-for-powerline
  - otf-hasklig # https://github.com/i-tu/Hasklig, fork of the Source Code Pro
  #  - ttf-meslo-nerd-font-powerlevel10k
  - montserrat-font-ttf

### Use "url" property for load ZIP archive or "urls" for an array of fonts to load directly
fonts_remotes:
  #  - name: FiraCode
  #    url: https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip
  #    path: "/ttf"
```
