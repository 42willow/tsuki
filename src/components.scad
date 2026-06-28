$fn = 30;

include <lib/BOSL2/std.scad>;
include <../dist/points.scad>;
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
    linear_extrude(height - 3 + 1.7) rotate([0, 0, 30]) hexagon(d=4 + 0.5); // compensation
    cylinder(h=height, d=2 + 0.3);
  }
}

module component_cutouts() {
  for (sign = [1, -1]) {
    // MCU (recessed)
    translate([sign * mcu_pos[0], mcu_pos[1], 0])
      linear_extrude(mcu_depth)
        rect(mcu_size);

    // charging module hole
    translate([sign * charging_module_pos[0], charging_module_pos[1], 0])
      linear_extrude(height)
        rect(charging_module_size, rounding=3);
  }
}
