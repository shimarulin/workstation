# Hardware

## Video

### Intel. VAAPI (Video Acceleration API)

#### Intel Media Driver for VAAPI — Broadwell+ iGPUs

Hardware Supported (https://github.com/intel/media-driver/#supported-platforms)

> - BDW (Broadwell)
> - SKL (Skylake)
> - BXTx (BXT: Broxton, APL: Apollo Lake, GLK: Gemini Lake)
> - KBLx (KBL: Kaby Lake, CFL: Coffe Lake, WHL: Whiskey Lake, CML: Comet Lake, AML: Amber Lake)
> - ICL (Ice Lake)
> - JSL (Jasper Lake) / EHL (Elkhart Lake)
> - TGLx (TGL: Tiger Lake, RKL: Rocket Lake, ADL-S/P/N: Alder Lake)
> - DG1/SG1
> - Alchemist(DG2)/ATSM

```shell
sudo pacman -S intel-media-driver
```

#### VAAPI implementation for Intel G45 and HD Graphics family

Hardware Supported (https://01.org/linuxmedia/vaapi)

> - Intel® GMA X4500HD.
> - Intel® HD Graphics (in Intel® 2010 Core™ i7/i5/i3 processor family).
> - Intel® HD Graphics 2000/3000 (in 2nd Generation Intel® Core™ i7/i5/i3 Processor family).
> - Intel® HD Graphics 2500/4000 (in 3nd Generation Intel® Core™ i7/i5/i3 Processor family).
> - Intel® HD Graphics 4200/4400/4600/5000, Intel® Iris™ Graphics 5100, and Intel® Iris™ Pro Graphics 5200 (in 4nd Generation Intel® Core™ i7/i5/i3 Processor family).

```shell
sudo pacman -S libva-intel-driver
```
