# Setup Oh My Zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/oh-my-zsh.sh
#
# Set ZSH_CACHE_DIR to the path where cache files should be created
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
# Create cache and completions dir and add to $fpath
mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
HISTFILE="$HOME/.config/zsh/.zsh_history"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm#settings
zstyle ':omz:plugins:nvm' autoload yes
