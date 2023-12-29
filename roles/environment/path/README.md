# Ansible Role "path"

> Setup $PATH for executable files

## Rationale

User-specific executable files may be stored in `$HOME/.local/bin`. Distributions should ensure this directory shows up
in the UNIX `$PATH` environment variable, at an appropriate place (see
https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html). Arch Linux uses `$HOME/.local/bin` to
store the user's local executables, but this directory is not added to `$PATH` by default.

## License

MIT
