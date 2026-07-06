$fn = $preview ? 30 : 120;

include <lib/BOSL2/std.scad>;
include <./vars.scad>;
use <./mount.scad>;
use <./components.scad>;

render() {
  block_w = mcu_size[0] + 4;
  block_d = mcu_size[1] + 4;

  difference() {
    union() {
      // difference() {
      //   translate([-block_w, -block_d / 2, 0])
      //     cube([block_w, block_d, height]);
      //   translate([-block_w / 2, 0, 0])
      //     linear_extrude(mcu_depth)
      //       rect(mcu_size);
      // }
      translate([cx / 2, 0, 0])
        mount();
    }
    translate([14, 5, 0])
      screw_bottom();
  }
}
