$fn = 30;

include <lib/BOSL2/std.scad>;
include <../dist/points.scad>;
use <./mount.scad>;

cx = 18;
cy = 17;
kx = cx - .5;
ky = cy - .5;

height = 5.5 - 2.20;

render() {
  difference() {
    union() {
      intersection() {
        outlines();
        mounts();
      }
      difference() {
        outlines();
        cutouts();
      }
    }
    screw_holes();
  }
}

module mounts() {
  rev = [1, 2, 3, 18, 19, 20];
  for (i = [0:len(points) - 1]) {
    point = points[i];
    render() translate([point[0], point[1], 0]) if (i + 1 >= 18) {
        // right side
        if (len(search(i + 1, rev)) > 0) {
          rotate([0, 0, point[2]])
            mirror([0, 1])
              mount();
        } else {
          rotate([0, 0, point[2] + 180])
            mirror([0, 1])
              mount();
        }
      } else {
        // left side
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

module cutouts() {
  color("orange")
    linear_extrude(height) {
      for (point = points) {
        echo(point);
        translate([point[0], point[1], 0])
          rotate([0, 0, point[2]])
            square([cx, cy], center=true);
      }
    }
}

module outlines() {
  color("brown")
    linear_extrude(height) {
      translate([cx / 2, 0, 0]) import("./outline.svg", layer="main");
      mirror([1, 0]) translate([cx / 2, 0, 0]) import("./outline.svg", layer="main");
    }
}

module screw_holes() {
  screws = [
    [cx / 2 + 3, 3],
    [cx / 2 + 3, 51.3],
    [114, 8],
    [114, 50.7],
  ];

  for (pos = screws) {
    translate(pos) screw();
    mirror([1, 0]) translate(pos) screw();
  }

  module screw() {
    union() {
      linear_extrude(height - 3 + 1.7) rotate([0, 0, 30]) hexagon(r=2);
      cylinder(h=height, d=2);
    }
  }
}
