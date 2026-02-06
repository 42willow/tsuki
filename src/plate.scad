$fn = 30;

include <lib/BOSL2/std.scad>;
include <./outline.scad>;
include <../dist/points.scad>;
use <./mount.scad>;

cx = 18;
cy = 17;
kx = cx - .5;
ky = cy - .5;

height = 5.5 - 2.20;
diam = 1.2; // wire diameter
gasket = [30, 3, 3];

screws = [
  [1.6 * cx, 2],
  [cx, 56],
  [114, 8],
  [114, 50.7],
];

render() plate();

module plate() {
  difference() {
    union() {
      linear_extrude(height) difference() {
          region(offset(outlines, r=gasket[1] + .5));
          region(cutouts());
        }
      mounts();
    }

    difference() {
      up(1) linear_extrude(height - 1) region(offset(outlines, r=5));
      linear_extrude(height) region(outlines);
    }

    screws() screw_bottom();

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

function cutouts(size = [cx, cy], rounding = 0) =
  [
    for (point = points) move(
      [point[0], point[1]],
      p=zrot(point[2], p=rect(size, rounding))
    ),
  ];

module screws() {
  for (pos = screws) {
    translate(pos) children();
    mirror([1, 0]) translate(pos) children();
  }
}

module screw_bottom() {
  union() {
    linear_extrude(height - 3 + 1.7) rotate([0, 0, 30]) hexagon(r=2);
    cylinder(h=height, d=2);
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
  points =
  round_corners(
    [
      for (i = [0:len(column) - 1]) each if (i == 0) [
        solder_point(column[i], offset, vert=1),
      ] else if (i == len(column) - 1) [
        solder_point(column[i], offset, vert=4),
        solder_point(column[i], offset, vert=-1),
      ] else [
        solder_point(column[i], offset),
        solder_point(column[i], offset, vert=-3),
      ],
    ],
    closed=false,
    r=4
  );

  echo(points);
  wire = square([diam, diam], center=true);

  path_sweep2d(wire, points);
}

v_offset = 1.68 - diam / 2;
// pos:
//   1: top-most switch
//   0: in the middle
//   -1: bottom-most switch
function solder_point(key, offset, vert = 0) =
  zrot(
    a=key[2],
    cp=[key[0], key[1]],
    p=back(
      y=(v_offset * vert), p=move(
        v=offset,
        p=[key[0], key[1]]
      )
    )
  );

function x(n) = points[n - 1][0];
function y(n) = points[n - 1][1];
