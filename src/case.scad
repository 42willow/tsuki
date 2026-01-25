$fn = 30;

include <lib/BOSL2/std.scad>;
include <../dist/points.scad>;
use <./mount.scad>;

cx = 18;
cy = 17;
kx = cx - .5;
ky = cy - .5;

rev = [1, 2, 3, 18, 19, 20];

for (i = [0:len(points) - 1]) {
  point = points[i];

  render() translate([point[0], point[1], -3]) if (i + 1 >= 18) {
      // right side
      if (len(search(i + 1, rev)) > 0) {
        rotate([0, 0, point[2]])
          mirror([0, 1])
            mount();
      } else {
        rotate([0, 0, point[2] + 180])
          mirror([0, 1])
            mount();
      }
    } else {
      // left side
      if (len(search(i + 1, rev)) > 0) {
        rotate([0, 0, point[2] + 180])
          mount();
      } else {
        rotate([0, 0, point[2]])
          mount();
      }
    }
  ;
}

// outline
color("brown") translate([cx / 2, 0, 0]) import("./outline.svg", layer="main");
color("brown") mirror([1, 0]) translate([cx / 2, 0, 0]) import("./outline.svg", layer="main");
