$fn = 5;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <./vars.scad>;

wall_t = 5; // wall thickness
outer_r = 2;
inner_r = 0.5;
top_h = height + 3;
bottom_h = 6;

case_rgn = offset(outlines, r=wall_t + gasket[1] + gasket_offset + .2);

module bottom_case() {
  color("blue")
    difference() {
      down(bottom_h) offset_sweep(case_rgn, height=bottom_h, top=os_circle(r=inner_r), bottom=os_circle(r=outer_r));

      // clear empty space
      down(bottom_h - 2) {
        linear_extrude(bottom_h)
          region(outlines);
        up(2)
          linear_extrude(bottom_h)
            region(offset(case_rgn, -wall_t));
      }

      // magnets
      down(4) {
        magnets();
        xflip() magnets();
      }
    }
}

module magnets() {
  linear_extrude(3) hull() {
      translate([11, 20]) circle(d=4);
      translate([133, 20]) circle(d=4);
    }
}

render() bottom_case();
