$fn = 30;

include <lib/BOSL2/std.scad>;
include <../dist/points.scad>;
use <./keycaps.scad>;

cx = 18;
cy = 17;
kx = cx - .5;
ky = cy - .5;

for (point = points) {
  echo(point);
  translate([point[0], point[1], 0])
    rotate([0, 0, point[2]])
    // difference()
    {
      translate([0, 0, 10]) keycap();
      // linear_extrude(4) square(size=[kx, ky], center=false);
      // color("grey") linear_extrude(2) import("library/choc_hotswap.dxf");
    }
}
