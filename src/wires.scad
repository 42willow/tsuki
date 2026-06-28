$fn = 30;

include <lib/BOSL2/std.scad>;
include <./vars.scad>;
include <./outline.scad>;

module row_wires(bez, N = 3) {
  down(wire_diam / 2) linear_extrude(wire_diam * 2) {
      for (i = [0:2])
        fwd(2.5 + cy * i)
          stroke(
            width=wire_diam,
            endcaps="butt",
            bezpath_curve(bez, N=N)
          );
    }
}

module column_wires(matrix, column_offsets) {
  transposed_matrix = [
    for (j = [0:max([for (row = matrix) len(row)]) - 1]) [
      for (i = [0:len(matrix) - 1]) if (j < len(matrix[i])) matrix[i][j],
    ],
  ];

  // wire channels
  for (i = [0:len(transposed_matrix) - 1]) {
    column_wire(transposed_matrix[i], column_offsets[i]);
  }
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

  wire = square([wire_diam, wire_diam], center=true);

  path_sweep2d(wire, points);
}

function _nearest_on_curve(curve, x) =
  let (
    diffs = [for (p = curve) abs(p[0] - x)],
    min_diff = min(diffs),
    idx = search(min_diff, diffs)[0]
  ) curve[idx];

module row_wells(bez, xs, N = 3) {
  curve = bezpath_curve(bez, N=N, splinesteps=200);
  for (i = [0:2])
    fwd(2.5 + cy * i)for (x = xs)
      let (pt = _nearest_on_curve(curve, x))
      translate([pt[0], pt[1], 0])
        rotate([0, 90, 0])
          cylinder(h=2, d=5.4, center=true);
}

module column_wells(matrix, column_offsets) {
  for (i = [0:len(matrix[0]) - 1]) {
    key = matrix[0][i];
    pt = solder_point(key, column_offsets[i], vert=1);
    translate([pt[0], pt[1], 0])
      back(1)
        rotate([90, 0, 0])
          cylinder(h=2, d=4, center=true);
  }
}

v_offset = 1.68;
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
