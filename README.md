> [!note]
> this project is a work in progress

# tsuki

a 34-key wireless hot-swappable choc v2 ortholinear split keyboard

fun fact! this keyboard was originally going to be fully handwired - i was actually almost there until i realised buying small reversible PCBs from jlcpcb is only $5aud including shipping. the 3d printed plate and case can be viewed [here](https://github.com/42willow/tsuki/tree/6ec3f66f3d0cb087d3a061690aaaaf412537c12d) - and built with `nix build github:42willow/tsuki/6ec3f66`

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
|    1     | 3mm plywood                        | [plyco](https://plyco.com.au/products/blackwood-laserply?variant=46193680023781) |
|    2     | PCB                                | jlcpcb                                                                           |
|    8     | M2 nuts and bolts                  |                                                                                  |
|    2     | JST connector                      |                                                                                  |
|    2     | SS12F15 switch                     | [aliexpress](https://www.aliexpress.com/item/1005008584425165.html)              |
|    2     | 602025 250mAh LiPo battery         | [ecocell](https://ecocell.com.au/product/lipo-250-602025/)                       |

### keycaps

tsuki uses choc v2 switches, which have an MX stem, at a choc size.\
i printed the [KLP Lamé](https://github.com/braindefender/KLP-Lame-Keycaps) keycaps at a 120 degree angle (iirc) successfully on an FDM 3D printer - i'd recommend using a brim, printing by object, and using a 0.2mm nozzle, although this takes a while!

### layers

#### top case

laser cut 3mm plywood
ideally this is engraved at a depth of around 1.5-2mm along the gasket edge to minimise wasted vertical space

#### plate

gasket mounted, 1.5mm POM engraved to a depth of 1.3mm around the perimeter of the switches

#### pcb

reversible, with a cutout for a 602025 LiPo battery - original is going to be autorouted

#### bottom case

3D printed, with inbuilt folding tenting embedded in the bottom case
like [this design](https://www.printables.com/model/1009802-v2-minimalistic-laptop-folding-feet-heavy-duty-lan)
will probably use [dowel pins](https://www.aliexpress.com/item/1005009029254273.html) for less resistance and everyday use - ideally the tenting should only take up a few millimeters for lowest profile possible

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
