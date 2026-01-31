$fn = 30;

include <lib/BOSL2/std.scad>;
use <./plate.scad>;
use <./cover.scad>;

render() {
  plate();
  cover();
}

// battery
// color("red") translate([35, 0, 8]) {
//     square(size=[30, 12], center=false);
//   }
