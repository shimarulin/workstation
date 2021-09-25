
# Add Rust executable binary files to path
# If ~/.cargo/bin exists and is a directory & if ~/.cargo/bin is not already in your $PATH
# then export ~/.cargo/bin to your $PATH.
CARGO_BIN=$HOME/.cargo/bin
if [[ -d $CARGO_BIN && -z $(echo $PATH | grep -o $CARGO_BIN) ]]
then
    export PATH="${PATH}:$CARGO_BIN"
fi

# Add user defined executable binary files to path
# If ~/.local/bin exists and is a directory & if ~/.local/bin is not already in your $PATH
# then export ~/.local/bin to your $PATH.
USER_BIN=$HOME/.local/bin
if [[ -d $USER_BIN && -z $(echo $PATH | grep -o $USER_BIN) ]]
then
    export PATH="${PATH}:$USER_BIN"
fi
