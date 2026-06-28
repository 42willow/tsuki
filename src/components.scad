$fn = 30;

include <lib/BOSL2/std.scad>;
include <./vars.scad>;

function cutouts(size = [cx, cy], rounding = 0) =
  [
    for (point = points) move(
      [point[0], point[1]],
      p=zrot(point[2], p=rect(size, rounding))
    ),
  ];

module screws() {
  for (pos = screws) {
    translate(pos) children();
    mirror([1, 0]) translate(pos) children();
  }
}

module screw_bottom() {
  union() {
    linear_extrude(height - 3 + nut_height) rotate([0, 0, 30]) hexagon(d=4 + screw_hex_tolerance);
    cylinder(h=height, d=2 + screw_shaft_tolerance);
  }
}

module component_cutouts() {
  for (sign = [1, -1]) {
    // MCU (recessed)
    translate([sign * mcu_pos[0], mcu_pos[1], 0]) {
      linear_extrude(mcu_depth)
        rect(mcu_size);
      linear_extrude(height) {
        left(mcu_size[0] / 2 - 1.25) rect([2.5, mcu_size[1]]);
        right(mcu_size[0] / 2 - 1.25) rect([2.5, mcu_size[1]]);
      }
    }

    // charging module hole
    translate([sign * charging_module_pos[0], charging_module_pos[1], 0])
      linear_extrude(height)
        rect(charging_module_size, rounding=3);
  }
}
