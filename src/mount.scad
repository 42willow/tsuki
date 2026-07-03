$fn = 100;

include <lib/BOSL2/std.scad>;
include <./vars.scad>;

// plate key mount

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf
// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG135001S30-Choc-Socket.pdf

// translate([0, 0, height])
//   rotate([0, 180, 0])
render() mount();

module mount(
  i = 1,
  flip = false,
  bt = "A", // bottom type
  tt = "A" // top type (A = away from pin holes, B = towards pin holes)
) {
  point = points[i - 1];
  translate([point[0], point[1], 0])
    zrot(point[2] + (flip ? 0 : 180))
      difference() {
        union() {
          outer();
          inner();
        }
        hotswap();

        // bottom wire inset
        if (bt == "A") {
          // right(6) up(1) cuboid([4, 2, 2]);
          back(1) right(6.5) up(1) cuboid([5, 4, 2]);
          right(3.75) cuboid([1, 1, 3]);
          right(3.25) cylinder(h=height, d=1);
        } else if (bt == "B")
          left(3.52) {
            back(3) up(1) cuboid([1.7, 6, 2]);
            // TODO cutout for the diode
            cylinder(h=height, d=1);
          }

        // top wire inset
        // if tt==A and bt==A we do straight line up on LHS
        // if tt==A and bt==B we do a loop thing and then straight line down on RHS
        // if tt==B and bt==A we do straight line up on RHS
        // if tt==B and bt==B we do straight line down on RHS
        if (bt == "A" && tt == "A") right(3.25) up(height - 1) fwd(3) cuboid([1, 6, 2]);
        if (bt == "B" && tt == "A") left(3.25) up(height - 1) fwd(3) cuboid([1, 6, 2]);

        // straight line down on RHS
        if (tt == "B") left(6) up(height - 1) back(3) cuboid([1, 6, 2]);
      }
}
// right(3.25) up(height) cuboid([1.5, 1, height]);

module mounts() {
  mount(1, flip=false);
  mount(2, flip=false);
  mount(3, flip=false);
  mount(4);
  mount(5);
  mount(6);
  mount(7, bt="A"); // TODO: is BT B even needed?
  mount(8, bt="A"); // TODO: is BT B even needed?
  mount(9, bt="A"); // TODO: is BT B even needed?
  mount(10, bt="A"); // TODO: is BT B even needed?
  mount(11, bt="A"); // TODO: is BT B even needed?
  mount(12, bt="A"); // TODO: is BT B even needed?
  mount(13, bt="A"); // TODO: is BT B even needed?
  mount(14, bt="A"); // TODO: is BT B even needed?
  mount(15, bt="A"); // TODO: is BT B even needed?
  mount(16, bt="A"); // TODO: is BT B even needed?
  mount(17, bt="A"); // TODO: is BT B even needed?

  mount(18, flip=false);
  mount(19, flip=false);
  mount(20, flip=false);
  mount(21);
  mount(22);
  mount(23);
  mount(24);
  mount(25);
  mount(26);
  mount(27);
  mount(28);
  mount(29);
  mount(30);
  mount(31);
  mount(32);
  mount(33);
  mount(34);
}

module outer() {
  // choc 18mm x 17mm sleeve
  linear_extrude(height) difference() {
      square([18, 17], center=true);
      square(15, center=true);
    }
}

module hotswap() {
  linear_extrude(2)
    // translate([5.0, 9.7])
    rotate([0, 0, 0])
      offset(delta=hotswap_tolerance)
        import("../assets/choc_hotswap.dxf");
}

module inner() {
  difference() {
    linear_extrude(height) square(15, center=true);

    union() {
      // holes
      linear_extrude(height) {
        circle(d=4.80 + center_hole_tolerance);

        translate([0, 5.90]) circle(d=3 + pin_hole_tolerance);
        translate([5, 3.80]) circle(d=3 + pin_hole_tolerance);
      }
    }
  }
}
