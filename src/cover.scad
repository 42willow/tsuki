$fn = 30;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
use <./plate.scad>;
use <./components.scad>;

height = 3;

render() cover();

module cover() {
  color("brown") up(5.5 - 2.2) difference() {
        linear_extrude(3) difference() {
            region(outlines);
            region(cutouts(15 + .1, 1));
          }
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
