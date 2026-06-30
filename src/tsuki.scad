$fn = 10;

include <lib/BOSL2/std.scad>;
use <./plate.scad>;
use <./cover.scad>;
use <./case.scad>;

render() difference() {
    union() {
      plate();
      cover();
      bottom_case();
    }
    left(500) down(25) fwd(30) cube([1000, 38, 50]);
  }
