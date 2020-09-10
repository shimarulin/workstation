# ansible-role-zsh

> Install and setup zsh

## Docs

- https://www.reddit.com/r/zsh/comments/g1nm2x/zdharmazinit/g22egyx/?utm_source=reddit&utm_medium=web2x&context=3
- https://github.com/unixorn/zsh-quickstart-kit
- https://unix.stackexchange.com/questions/589183/how-do-you-convert-or-translate-these-zplug-codes-whose-uncommon-option-into-zin

## Articles

- https://www.ataias.com.br/2020/04/10/a-shell-configuration/
- https://callstack.com/blog/supercharge-your-terminal-with-zsh/
- https://hund0b1.gitlab.io/2018/08/04/spell-check-and-auto-correction-of-commands-in-zsh.html
- https://blog.confirm.ch/zsh-tips-auto-completion-correction/

## Themes

- https://denysdovhan.com/spaceship-prompt/

## Examples

- https://github.com/zdharma/zinit-configs
- https://gist.github.com/meskarune/6a647b067de3addd045f11c07aaf1cfc
- https://github.com/dgo-/dotfiles/blob/master/zsh/zshrc
- https://github.com/montaropdf/zsh-config/blob/apollo/zshrc.apollo
- https://github.com/zdharma/zinit-configs/blob/master/psprint/zshrc.zsh
- https://github.com/crivotz/dot_files/blob/master/linux/zplugin/zshrc
- https://github.com/yusabana/dotfiles/blob/master/zshdir/zshrc.zplugin

## Plugins

- https://github.com/ohmyzsh/ohmyzsh
- https://github.com/mbrubeck/compleat

### Manage plugins

- https://github.com/zdharma/zinit

## Settings

### Autocompletion

- https://docs.haskellstack.org/en/stable/shell_autocompletion/
- https://github.com/zsh-users/zsh-completions (https://www.archlinux.org/packages/community/any/zsh-completions/)

## Requirements

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the
role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

## Role Variables

A description of the settable variables for this role should go here, including any variables that are in
defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables
that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as
well.

## Dependencies

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set
for other roles, or variables that are used from other roles.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for
users too:

    - hosts: servers
      roles:
         - { role: zsh, x: 42 }

## License

MIT
