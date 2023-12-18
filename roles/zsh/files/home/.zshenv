# Load profiles from $XDG_CONFIG_HOME/profile.d
profiles_path=$(test -z "$XDG_CONFIG_HOME" && echo "$XDG_CONFIG_HOME/profile.d" || echo "$HOME/.config/profile.d")
if test -d "$profiles_path"; then
  for profile in "$profiles_path"/*.sh; do
    test -r "$profile" && emulate sh -c "source $profile"
  done
  unset profile
fi
unset profiles_path

ZDOTDIR=$HOME/.config/zsh
