$fn = 30;

include <lib/BOSL2/std.scad>;
use <./plate.scad>;

height = 3 * 2 + 3.3 + 2;
magnet = [4, 3];

render() bottom();

module bottom() {
  color("blue") difference() {
      down(3 + 2.9) linear_extrude(3) offset(5) outlines();
      down(2) linear_extrude(2) outlines();
    }
}
