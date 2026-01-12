$fn = 200;
include <lib/BOSL2/std.scad>

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf
// https://shop.beekeeb.com/products/thcs-blank-black-keycaps

union() {
  key();
  translate([0, 0, kt])
    stem();
}

// stem
st = 0.05; // tolerance
ss = 1.3 + st; // stroke
sw = 4 + st; // width
sd = 5.5 - st; // diameter

module stem() {
  plus = union(
    rect([ss, sw]), // horizontal bar
    rect([sw, ss]), // vertical bar
  );

  difference() {
    cylinder(h=kz - kt, d=sd, center=false);

    offset_sweep(
      plus,
      height=kz - kt,
      top=os_chamfer(height=-.2) // chamfer at top only
    );
  }
}

// key
kx = 17.5; // length
ky = 16.5; // width
kz = 3; // height
kr = 1.5; // radius
kt = 0.6; // thickness

module key()
  difference() {
    offset_sweep(rect([kx, ky], rounding=kr), h=kz, bot=os_circle(r=kt));
    translate([0, 0, kt]) linear_extrude(kz) offset(-kt) rect([kx, ky], rounding=kr);
  }
