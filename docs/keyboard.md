# Keyboard

## Troubleshooting

### Keyboard unresponsive some time after boot or sleep on laptop

If laptop keyboard not working some time after boot or sleep on laptop, try to add `i8042.dumbkbd` to your kernel boot
parameters. In this case, the LEDs of the laptop keyboard will not work, but the LEDs of the connected USB keyboard
work as expected.

Some parameters for the kernel modules related to the keyboard are given below:

```
  atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
			EzKey and similar keyboards

	atkbd.reset=	[HW] Reset keyboard during initialization
	i8042.debug	[HW] Toggle i8042 debug mode
	i8042.unmask_kbd_data
			[HW] Enable printing of interrupt data from the KBD port
			     (disabled by default, and as a pre-condition
			     requires that i8042.debug=1 be enabled)
	i8042.direct	[HW] Put keyboard port into non-translated mode
	i8042.dumbkbd	[HW] Pretend that controller can only read data from
			     keyboard and cannot control its state
			     (Don't attempt to blink the leds)
	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
	i8042.nokbd	[HW] Don't check/create keyboard port
	i8042.noloop	[HW] Disable the AUX Loopback command while probing
			     for the AUX port
	i8042.nomux	[HW] Don't check presence of an active multiplexing
			     controller
	i8042.nopnp	[HW] Don't use ACPIPnP / PnPBIOS to discover KBD/AUX
			     controllers
	i8042.notimeout	[HW] Ignore timeout condition signalled by controller
	i8042.reset	[HW] Reset the controller during init, cleanup and
			     suspend-to-ram transitions, only during s2r
			     transitions, or never reset
			Format: { 1 | Y | y | 0 | N | n }
			1, Y, y: always reset controller
			0, N, n: don't ever reset controller
			Default: only on s2r transitions on x86; most other
			architectures force reset to be always executed
	i8042.unlock	[HW] Unlock (ignore) the keylock
	i8042.kbdreset	[HW] Reset device connected to KBD port

	i810=		[HW,DRM]
```
