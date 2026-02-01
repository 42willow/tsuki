$fn = 30;

include <lib/BOSL2/std.scad>;
use <./plate.scad>;
use <./cover.scad>;
use <./bottom.scad>;

render() difference() {
    union() {
      plate();
      cover();
      bottom();
    }
    left(500) down(25) fwd(30) cube([1000, 38, 50]);
  }

// battery
// color("red") translate([35, 0, 8]) {
//     square(size=[30, 12], center=false);
//   }
