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
    linear_extrude(height - 3 + 1.7) rotate([0, 0, 30]) hexagon(r=2);
    cylinder(h=height, d=2);
  }
}
