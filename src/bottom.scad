$fn = 30;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <./vars.scad>;
use <./plate.scad>;

magnet = [4, 3];

render() bottom();

module bottom() {
  color("blue") difference() {
      down(3 + 2.9) linear_extrude(3) region(offset(outlines, r=outline_offset));
      down(2) linear_extrude(2) region(outlines);
    }
}
