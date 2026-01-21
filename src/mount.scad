$fn = 100;

// plate key mount

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf
// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG135001S30-Choc-Socket.pdf

render() mount();

module mount() {
  difference() {
    union() {
      outer();
      inner();
    }
    hotswap();
  }
}

// inset: whether to leave a 3mm inset for plywood
module outer(inset = true) {
  // choc 18mm x 17mm sleeve
  linear_extrude(inset ? 5.5 - 2.20 : 5.5 + 1) difference() {
      square([18, 17], center=true);
      square(15, center=true);
    }
}

module hotswap() {
  linear_extrude(2)
    // translate([5.0, 9.7])
    rotate([0, 0, 0])
      offset(delta=.3)
        import("../assets/choc_hotswap.dxf");
}

module inner(flat = true) {
  height = 5.5;

  difference() {
    linear_extrude(flat ? height - 2.20 : height) square(15, center=true);

    union() {
      // click fit
      if (flat == false) {
        grip = 0.9;
        translate([0, 0, height])
          rotate([180, 0, 0])
            linear_extrude(1.35) square(14 + (1 - grip) * .5, center=true);

        
        translate([0, 0, height - 1.35])
          rotate([180, 0, 0])
            linear_extrude(2.20 - 1.35) square(14.5, center=true);
      }

      // holes
      linear_extrude(height - 2.20 + 0.00001) {
        tolerance = 1.05;
        circle(d=4.80 * tolerance);

        translate([0, 5.90]) circle(d=3 * tolerance);
        translate([5, 3.80]) circle(d=3 * tolerance);
      }
    }
  }
}
