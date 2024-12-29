#!/bin/sh

# micro editor true color support
# ================================
# True color support in micro is off by default but can be enabled by setting
# the environment variable MICRO_TRUECOLOR to 1. In addition your terminal
# must support it (usually indicated by setting $COLORTERM to truecolor)
#
# See:
#   - https://github.com/zyedidia/micro#:~:text=MICRO_TRUECOLOR
#   - https://github.com/zyedidia/micro/blob/master/runtime/help/colors.md#:~:text=darcula%20and%20more.-,true%2Dcolor,-%3A%20Some%20terminals%20support
export MICRO_TRUECOLOR=1
