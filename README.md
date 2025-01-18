# AyuGram Desktop for Arch Linux

A manually triggered compilation tool for AyuGram, designed to address startup issues in ayugram-desktop caused by protobuf updates.

Pkgbuilds from [AyugramDesktop](https://github.com/AyuGram/AyuGramDesktop)

Build with [arch repo builder](https://github.com/sakarie9/arch-repo-builder)

## Usage

`pacman -U {Link from release}`

or

Add following entry to `/etc/pacman.conf`

```conf
[maary-tg]
SigLevel = Optional
Server = https://github.com/Steve-Mr/telegram-archbuild/releases/download/repo
```
