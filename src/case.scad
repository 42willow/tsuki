$fn = 10;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <./vars.scad>;

wall_t = 3; // wall thickness
outer_r = 2;
top_h = height + 3 - 1.5;
bottom_h = 6 + 1.5;

case_rgn = offset(outlines, r=wall_t + plate_lip + .2);

lip_w = 1.5;
lip_h = 1.5;
lip_clearance = 0.1;

module bottom_case() {
  color("blue")
    union() {
      difference() {
        union() {
          // main shape
          down(bottom_h)
            offset_sweep(
              case_rgn,
              height=bottom_h,
              bottom=os_circle(r=outer_r)
            );
          // interlocking lip along the inner wall perimeter
          linear_extrude(lip_h)
            difference() {
              region(offset(case_rgn, -wall_t + lip_w));
              region(offset(case_rgn, -wall_t));
            }
        }

        // clear bottom ridge
        down(bottom_h - 2)
          linear_extrude(bottom_h)
            region(outlines);

        down(1.5 + gasket_squish) {
          // clear gasket ridge

          linear_extrude(bottom_h)
            difference() {
              region(offset(case_rgn, -wall_t));
              union() {
                offset(r=1) magnet_profile_2d();
                xflip() offset(r=1) magnet_profile_2d();
              }
            }

          // clear magnet inset on ridge
          linear_extrude(bottom_h)
            region(offset(outlines, r=.2));
        }

        // magnets
        down(3.5) {
          magnets();
          xflip() magnets();
        }

        // notch for case magnet wall clearance
        linear_extrude(height)
          union() {
            offset(r=1.3) magnet_profile_2d();
            xflip() offset(r=1.3) magnet_profile_2d();
          }
      }
    }
  // TODO battery slot
  // TODO usb c module slot
  // TODO charging module slot
}

module magnets() {
  linear_extrude(3 + .7) magnet_profile_2d();
}

module top_case() {
  color("lightblue")
    difference() {
      up(lip_clearance) offset_sweep(
          case_rgn,
          height=top_h - lip_clearance,
          top=os_circle(r=outer_r),
        );

      // clear empty space (leave 1mm wall around magnets)
      linear_extrude(gasket_squish)
        difference() {
          region(offset(case_rgn, -wall_t));
          union() {
            offset(r=1) magnet_profile_2d();
            xflip() offset(r=1) magnet_profile_2d();
          }
        }
      linear_extrude(top_h)
        region(offset(outlines, r=.2));

      // interlocking groove for bottom case lip (with clearance)
      linear_extrude(lip_h + lip_clearance)
        difference() {
          region(offset(case_rgn, -wall_t + lip_w + lip_clearance));
          region(offset(case_rgn, -wall_t));
          // avoid magnet area
          union() {
            offset(r=1) magnet_profile_2d();
            xflip() offset(r=1) magnet_profile_2d();
          }
        }

      // magnets
      up(.5) {
        magnets();
        xflip() magnets();
      }
    }
}

render() difference() {
    union() {
      top_case();
      bottom_case();
    }
    // left(500) down(25) fwd(30) cube([1000, 38, 50]);
    // left(50) cube([200, 200, 50], center=true);
  }
