########################################################################################################################
### Added by Zinit's installer
########################################################################################################################
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of lines added by Zinit's installer
########################################################################################################################

########################################################################################################################
# Lines configured by zsh-newuser-install
########################################################################################################################
# HISTFILE=~/.histfile
# HISTSIZE=20480
# SAVEHIST=20480
# setopt autocd extendedglob nomatch notify
# bindkey -e
# End of lines configured by zsh-newuser-install
########################################################################################################################

########################################################################################################################
# The following lines were added by compinstall
########################################################################################################################
zstyle :compinstall filename '/home/vagrant/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
########################################################################################################################

########################################################################################################################
### Oh-My-Zsh
########################################################################################################################
# zinit wait lucid for \
#   OMZ::lib/completion.zsh \
#   OMZ::lib/directories.zsh \
#   OMZ::lib/history.zsh \
#   OMZ::lib/key-bindings.zsh \
#   OMZ::plugins/command-not-found/command-not-found.plugin.zsh \

# omz_libraries=(
#     directories.zsh
#     key-bindings.zsh
#     history.zsh
#     completion.zsh
# )
# for library in ${omz_libraries[@]}; do
#     zinit snippet OMZL::$library
#     done

# omz_plugins=(
#     command-not-found
# )
# for plugin in ${omz_plugins[@]}; do
#     # zinit snippet OMZ::plugins/$plugin/$plugin.plugin.zsh
#     zinit snippet OMZP::$plugin
#     done

# zinit snippet OMZP::command-not-found
### End of Oh-My-Zsh chunk
########################################################################################################################

########################################################################################################################
### zinit-crasis (https://github.com/zdharma/zinit-crasis)
########################################################################################################################
zinit light zdharma/zui
zinit light zdharma/zinit-crasis
### End of zinit-crasis chunk
########################################################################################################################

########################################################################################################################
### zinit-console (https://github.com/zinit-zsh/zinit-console)
########################################################################################################################
zinit wait lucid for zinit-zsh/zinit-console
### End of zinit-console chunk
########################################################################################################################

########################################################################################################################
### Load Prompt (Powerlevel10k Theme)
########################################################################################################################
zinit ice depth=1
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ ${TERM} == "linux" ]]; then
  # Load config for Linux virtual terminal
  [[ ! -f ~/.p10k.tty.zsh ]] || source ~/.p10k.tty.zsh
else
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
### End of powerlevel10k chunk
########################################################################################################################
