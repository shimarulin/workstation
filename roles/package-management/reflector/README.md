# ansible-role-reflector

> Pacman mirrorlist updater

## Rationale

It is not optimal to only rank mirrors based on speed since the fastest servers might be out-of-sync. Instead, make a
list of mirrors sorted by their speed, then remove those from the list that are out of sync according to their
[status](https://archlinux.org/mirrors/status/).

It is recommended to regularly repeat this process to keep the list of mirrors up-to-date.

## License

MIT
