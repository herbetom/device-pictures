# Device Pictures

This repository contains vector graphics of routers used in the [Gluon-Firmware-Selector](https://github.com/freifunk-darmstadt/gluon-firmware-selector) and in the [Meshviewer](https://github.com/freifunk/meshviewer).
It can be equally used for OpenWRT Firmware selectors and the like.

This unifies the valuable work started by [Daniel Krah](https://github.com/Moorviper/Freifunk-Router-Anleitungen), [Julian Labus](https://github.com/belzebub40k/router-pics), [Jan Alexander](https://github.com/nalxnet/freifunk-device-images) and [freifunkstuff](https://github.com/freifunkstuff/meshviewer-hwimages).
The Pictures are available under [CC-BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Creating JPG and PNG

To create jpg and png files, you need to have imagemagick and inkscape installed. Rune

`./conversion-script.sh`

Output is written to `pictures-png` and `pictures-jpg` respectively.

## Symlinks

This repository symlinks version aliases instead of creating additional files.
Initially this was checked using fdupes.

The Gluon Autoupdater looks for the Model Name in the manifest (except for raspberry pi, where the board name is used).
The meshviewer receives the data from respondd through an aggregator like yanic, and therefore needs the whole Model Name too.

The firmware selector does cut off version related parts and looks for a picture without versions specified to show.
Therefore, multiple symlinks are created in the `conversion-script.sh` which take care of this.

For some devices, the Model name has been corrected in Openwrt throughout releases, which introduced a change and requires to keep an alias for the new name, as both versions may appear on a meshviewer (one with more recent firmware and one with less recent firmware).