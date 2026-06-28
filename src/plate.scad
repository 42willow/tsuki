$fn = $preview ? 30 : 120;

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
          region(offset(outlines, r=gasket[1] + gasket_offset_tolerance));
          region(cutouts());
        }
      mounts();
    }

    difference() {
      up(chamfer_offset) linear_extrude(height - chamfer_offset) region(offset(outlines, r=outline_offset));
      linear_extrude(height) region(outlines);
    }

    screws() screw_bottom();

    component_cutouts();

    column_wires(left_matrix, left_column_offsets);
    column_wells(left_matrix, left_column_offsets);
    row_wires(left_row_bez);
    row_wells(left_row_bez, left_well_xs);

    column_wires(right_matrix, right_column_offsets);
    column_wells(right_matrix, right_column_offsets);
    row_wires(right_row_bez, N=4);
    row_wells(right_row_bez, right_well_xs, N=4);
  }
}
// debug_bezier(left_row_bez, width=1);
// debug_bezier(right_row_bez, width=1, N=4);
