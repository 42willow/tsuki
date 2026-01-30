$fn = 30;

include <lib/BOSL2/std.scad>;
include <../dist/points.scad>;
use <./mount.scad>;

cx = 18;
cy = 17;
kx = cx - .5;
ky = cy - .5;

height = 5.5 - 2.20;
diam = 1.2; // wire diameter

render() {
  difference() {
    union() {
      difference() {
        outlines();
        cutouts();
      }
      intersection() {
        outlines();
        mounts();
      }
    }
    screw_holes();

    column_wires();
    xflip() column_wires();
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

module column_wires() {
  far_x = 9 + diam / 2;
  close_y = 3.8 - .08;
  close_x = 4.3 + diam / 2;
  far_y = 5.9;

  column_wire(
    [
      points[14],
      points[12],
      points[16],
    ],
    [-far_x, -close_y]
  );

  column_wire(
    [
      points[11],
      points[9],
      points[15],
    ],
    [-far_x, -close_y]
  );

  column_wire(
    [
      points[8],
      points[6],
    ],
    [-far_x, -close_y]
  );

  column_wire(
    [
      points[5],
      points[3],
    ],
    [close_x, -far_y]
  );

  column_wire(
    [
      points[2],
      points[0],
    ],
    [-close_x, far_y]
  );
}

module column_wire(
  column,
  offset
) {
  points = [
    for (key = column) each [
      solder_point(key, offset),
      solder_point(key, offset, bottom=true),
    ],
  ];
  wire = square([diam, diam], center=true);

  path_sweep2d(wire, points);
}

v_offset = 1.68 - diam / 2;
function solder_point(key, offset, bottom = false) =
  zrot(
    a=key[2],
    cp=[key[0], key[1]],
    p=back(
      y=bottom ? -v_offset : v_offset, p=move(
        v=offset,
        p=[key[0], key[1]]
      )
    )
  );

function x(n) = points[n - 1][0];
function y(n) = points[n - 1][1];
