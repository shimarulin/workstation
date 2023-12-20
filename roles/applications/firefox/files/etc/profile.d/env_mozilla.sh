#!/bin/sh

# Pixel-perfect trackpad scrolling
# ================================
# To enable one-to-one trackpad scrolling (as can be witnessed with GTK3 applications like Nautilus), set the MOZ_USE_XINPUT2=1 environment variable before starting Firefox.
# If scrolling is undesirably jerky, try enabling Firefox's Use smooth scrolling option under Preferences > General > Browsing.
#
# From: https://wiki.archlinux.org/title/Firefox/Tweaks#Pixel-perfect_trackpad_scrolling
export MOZ_USE_XINPUT2=1
