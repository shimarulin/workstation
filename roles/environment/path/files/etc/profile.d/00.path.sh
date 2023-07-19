#!/bin/sh

# If user ID is greater than or equal to 1000 &
# if ~/.local/bin exists and is a directory &
# if ~/.local/bin is not already in your $PATH
# then export ~/.local/bin to your $PATH.
# shellcheck disable=SC2039
if [[ $UID -ge 1000 && -d $HOME/.local/bin && -z $(echo $PATH | grep -o $HOME/.local/bin) ]]; then
  export PATH=$HOME/.local/bin:${PATH}
fi
