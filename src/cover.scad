$fn = 30;

include <lib/BOSL2/std.scad>;
use <./plate.scad>;

height = 3;

render() cover();

module cover() {
  color("brown") translate([0, 0, 5.5 - 2.2])
      difference() {
        linear_extrude(3) outlines();
        cutouts([15 + .1, 15 + .1]);
        screws() screw_top();
      }
}

module screw_top() {
  union() {
    translate([0, 0, height - 2])
      cylinder(h=2, d=4);
    cylinder(h=height, d=2);
  }
}
