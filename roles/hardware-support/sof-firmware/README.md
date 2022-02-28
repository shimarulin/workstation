# ansible-role-sof-firmware

> Sound Open Firmware (additional drivers)

Check hardware:

```shell
lspci -v | grep -A7 -i "Audio"
```

Example output:

```
0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
       Subsystem: Hewlett-Packard Company Device 87cb
       Flags: bus master, fast devsel, latency 32, IRQ 160
       Memory at 55444000 (64-bit, non-prefetchable) [size=16K]
       Memory at 55100000 (64-bit, non-prefetchable) [size=1M]
       Capabilities: <access denied>
       Kernel driver in use: sof-audio-pci-intel-tgl
       Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl
```

Supported devices:

- Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller

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
         - { role: sof-firmware, x: 42 }

## License

MIT
