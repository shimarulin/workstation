#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch toolbar and launch-bar
echo "---" | tee -a /tmp/polybar-toolbar.log /tmp/polybar-launch-bar.log
polybar toolbar >>/tmp/polybar-toolbar.log 2>&1 & disown
#polybar launch-bar >>/tmp/polybar-launch-bar.log 2>&1 & disown

echo "Bars launched..."
