#!/bin/sh

# If user ID is greater than or equal to 1000 &
# if ~/.cargo/bin exists and is a directory &
# if ~/.cargo/bin is not already in your $PATH
# then export ~/.cargo/bin to your $PATH.
if [[ $UID -ge 1000 && -d $HOME/.cargo/bin && -z $(echo $PATH | grep -o $HOME/.cargo/bin) ]]
then
    export PATH=$HOME/.cargo/bin:${PATH}
fi
