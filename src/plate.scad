$fn = 30;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <./vars.scad>;
use <./wires.scad>;
use <./mount.scad>;
use <./components.scad>;

render() plate();

module plate() {
  difference() {
    union() {
      linear_extrude(height) difference() {
          region(offset(outlines, r=gasket[1] + .5));
          region(cutouts());
        }
      mounts();
    }

    difference() {
      up(1) linear_extrude(height - 1) region(offset(outlines, r=5));
      linear_extrude(height) region(outlines);
    }

    screws() screw_bottom();

    column_wires();
    xflip() column_wires();
  }
}
