$fn = 10;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <./vars.scad>;

wall_t = 5; // wall thickness
outer_r = 2;
top_rx = wall_t;
top_ry = 2;
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

        // clear empty space
        down(bottom_h - 2)
          linear_extrude(bottom_h)
            region(outlines);
        down(1.5 + gasket_squish)
          linear_extrude(bottom_h)
            region(offset(case_rgn, -wall_t));

        // magnets
        down(3.5) {
          magnets();
          xflip() magnets();
        }
        up(.5) {
          magnets();
          xflip() magnets();
        }
      }
    }
  // TODO battery slot
  // TODO usb c module slot
  // TODO charging module slot
}

module magnets() {
  linear_extrude(3) hull() {
      translate([11, points[1][1]]) circle(d=4);
      translate([133, points[1][1]]) circle(d=4);
    }
}

module top_case() {
  color("lightblue")
    difference() {
      up(lip_clearance) offset_sweep(
          case_rgn,
          height=top_h - lip_clearance,
          top=os_profile(
            points=concat(
              [[0, 0]], [
                for (i = [1:16]) let (t = i * 90 / 16) [
                    top_rx * (1 - cos(t)),
                    top_ry * sin(t),
                ],
              ]
            )
          ),
        );

      // clear empty space
      linear_extrude(gasket_squish) // TODO
        region(offset(case_rgn, -wall_t));
      linear_extrude(top_h)
        region(offset(outlines, r=.2));

      // interlocking groove for bottom case lip (with clearance)
      linear_extrude(lip_h + lip_clearance)
        difference() {
          region(offset(case_rgn, -wall_t + lip_w + lip_clearance));
          region(offset(case_rgn, -wall_t));
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
