> [!note]
> this project is a work in progress

# tsuki

a 34-key FDM 3D printed handwired wireless hot-swappable choc v2 ortholinear split keyboard

## components

### parts

| quantity | name                               | store                                                                            |
| :------: | ---------------------------------- | -------------------------------------------------------------------------------- |
|    2     | nrf52840 MCU                       | [aliexpress](https://www.aliexpress.com/item/1005009890279520.html)              |
|    2     | USB C connectors                   | [aliexpress](https://www.aliexpress.com/item/1005009343824506.html)              |
|    34    | kailh choc v2 pink island switches | [aliexpress](https://www.aliexpress.com/item/1005010206448781.html)              |
|    34    | kailh choc v2 hotswap sockets      | [aliexpress](https://www.aliexpress.com/item/1005007232040760.html)              |
|    16    | keebox poron gaskets               | [aliexpress](https://www.aliexpress.com/item/1005003607093794.html)              |
|    10    | 4x3mm round magnets                | [aliexpress](https://www.aliexpress.com/item/1005010586827524.html)              |
|    1     | 1.5mm plywood                      | [plyco](https://plyco.com.au/products/blackwood-laserply?variant=46193680023781) |
|    2     | PCB                                | jlcpcb                                                                           |
|    8     | M2 nuts and bolts                  |                                                                                  |
|    2     | JST connector                      |                                                                                  |
|    2     | SS12F15 switch                     | [aliexpress](https://www.aliexpress.com/item/1005008584425165.html)              |
|    2     | 602025 250mAh LiPo battery         | [ecocell](https://ecocell.com.au/product/lipo-250-602025/)                       |

### case

3D printed

### keycaps

tsuki uses choc v2 switches, which have an MX stem, at a choc size.\
i printed the [KLP Lamé](https://github.com/braindefender/KLP-Lame-Keycaps) keycaps at a 120 degree angle (iirc) successfully on an FDM 3D printer - i'd recommend using a brim, printing by object, and using a 0.2mm nozzle, although this takes a while!

### plate

tsuki doesn't have a PCB, although to make this you need a 3d printer - if you don't have access to one of those this is not the design for you.

## firmware

[ZMK](https://github.com/zmkfirmware/zmk)

## build guide

## photos

coming soon!

## future plans

- encoder on left hand side: https://github.com/EverydayErgo/MEH01
- OLED on left hand side: SSD1306 (.96" squarish)
- trackpad on right hand side: cirque curved overlay (35mm or 40mm)
  - haptic feedback: pimoroni DRV2605L

OR on each side:

- encoder: https://github.com/EverydayErgo/MEH01
- display:
  - OLED: SSD1306 (.91" long)
  - e-ink: [GDEM0097T61](https://www.aliexpress.com/item/1005004332530295.html) (.97" long)

uses of the display:

- layers
- connection
- wpm
- time
- decorations

uses of the encoder:

- scrolling
- zooming
- volume

although i just discovered none of these are viable without a diode matrix design... guess i'll be using THT diodes because that's what i have and i don't think im ready for SMT.

i think display and trackpad isn't necessary, but encoder would be nice - can do diodeless with one pin to spare with an encoder if i use the three bonus pins

## resources

- <https://github.com/stars/42willow/lists/keyboards>
- [ergogen](https://github.com/ergogen/ergogen)
