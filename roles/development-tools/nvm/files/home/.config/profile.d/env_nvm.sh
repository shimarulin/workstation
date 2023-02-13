#!/bin/sh

# If user ID is greater than or equal to 1000 &
# if ~/.config/nvm exists and is a directory
# then export NVM_DIR and sourced $NVM_DIR/nvm.sh.
if [[ $UID -ge 1000 && -d $HOME/.config/nvm ]]
then
    export NVM_DIR="$HOME/.config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi
