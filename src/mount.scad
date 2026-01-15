$fn = 100;

// plate key mount

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf

render()
  difference() {
    union() {
      sleeve();
      mount();
    }
    hotswap();
  }

module sleeve() {
  // choc 18mm x 17mm sleeve
  linear_extrude(5.5 + 1) difference() {
      square([18, 17], center=true);
      square(15, center=true);
    }
}

module hotswap() {
  linear_extrude(2)
    translate([5.0, 9.6])
      rotate([0, 0, 180])
        offset(delta=.05)
          import("../assets/choc_hotswap.dxf");
}

module mount() {
  height = 5.5;

  difference() {
    linear_extrude(height) square(15, center=true);

    // click fit
    union() {
      translate([0, 0, height])
        rotate([180, 0, 0])
          linear_extrude(1.35) square(13.95 + 0.05, center=true);

      
      translate([0, 0, height - 1.35])
        rotate([180, 0, 0])
          linear_extrude(2.20 - 1.35) square(14.5, center=true);

      
      // holes
      linear_extrude(3.301) {
        circle(d=4.80);

        translate([0, 5.90]) circle(d=3);
        translate([5, 3.80]) circle(d=3);
      }
    }
  }
}
