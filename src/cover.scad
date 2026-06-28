$fn = 30;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <./vars.scad>;
use <./plate.scad>;
use <./components.scad>;

cover_thickness = 3;

render() cover();

module cover() {
  color("brown") up(height) difference() {
        linear_extrude(cover_thickness) difference() {
            region(outlines);
            region(cutouts(15 + switch_cutout_tolerance, 1));
          }
        screws() screw_top();
      }
}

module screw_top() {
  union() {
    translate([0, 0, cover_thickness - 2])
      cylinder(h=2, d=4);
    cylinder(h=cover_thickness, d=2);
  }
}
