# Ansible Role "install_fonts"

> Load and install font from remotes

## Role Variables

### `item`

Item options:

- `name`: font name (used to create font directory)
- `url` (zip-only): link to zip archive
- `path` (zip-only): path to the font directory relative to the archive root
- `urls` (source-only): an array of links to font files for direct download

#### Examples

Install from list of URLs:

```yaml
item:
  name: "MesloLGS NF"
  urls:
    - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
```

Install from ZIP package with path:

```yaml
item:
  name: "FiraCode"
  url: "https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip"
  path: "/ttf"
```

## Example Playbook

```yaml
---
- name: "Apply common configuration to all nodes "# noqa: role-name[path]
  hosts: "all"
  roles:
    - role: "fonts/install-fonts" # noqa: role-name[path]
      vars:
        item:
          name: "MesloLGS NF"
          urls:
            - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
            - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
            - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
            - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
      tags:
        - laptop
        - desktop
```

## Example Task

```yaml
---
# tasks file for "meslo_lgs_nf_source" role
- name: "Install MesloLGS NF from sources"
  ansible.builtin.include_role:
    name: "fonts/install_fonts"
  vars:
    item:
      name: "MesloLGS NF"
      urls:
        - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
        - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
        - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
        - "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
```

## License

MIT
