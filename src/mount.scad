$fn = 100;

// plate key mount

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf
// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG135001S30-Choc-Socket.pdf

height = 5.5 - 2.20;

tolerances = [
  .26, // hotswap
  .18, // central hole
  .03, // pin holes
];

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
      offset(delta=tolerances[0])
        import("../assets/choc_hotswap.dxf");
}

module inner() {
  difference() {
    linear_extrude(height) square(15, center=true);

    union() {
      // holes
      linear_extrude(height) {
        circle(d=4.80 + tolerances[1]);

        translate([0, 5.90]) circle(d=3 + tolerances[2]);
        translate([5, 3.80]) circle(d=3 + tolerances[2]);
      }
    }
  }
}
