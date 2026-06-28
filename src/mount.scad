$fn = 100;

include <./vars.scad>;

// plate key mount

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf
// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG135001S30-Choc-Socket.pdf

translate([0, 0, height])
  rotate([0, 180, 0])
    render() mount();

 module mount() {
  rotate([0, 0, 180])
    difference() {
      union() {
        outer();
        inner();
      }
      hotswap();
    }
}

module mounts() {
  rev = [1, 2, 3, 18, 19, 20];
  for (i = [0:len(points) - 1]) {
    point = points[i];
    render() translate([point[0], point[1], 0]) {
        if (len(search(i + 1, rev)) > 0) {
          rotate([0, 0, point[2] + 180])
            mount();
        } else {
          rotate([0, 0, point[2]])
            mount();
        }
      }
  }
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
