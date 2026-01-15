// plate key mount

// https://github.com/keyboardio/keyswitch_documentation/blob/master/datasheets/Kailh/CPG1353S01D01-01.pdf

difference() {
  difference() {
    linear_extrude(5.5) square(15, center=true);

    linear_extrude(1.35) square(13.95 + 0.05, center=true);

    translate([0, 0, 1.35])
      linear_extrude(2.20) square(14.5, center=true);
  }

  // 4.80 center circle
  translate([0, 0, 0]) cylinder(h=20, d=4.80, center=true);
}

import("../assets/choc_hotswap.dxf");
