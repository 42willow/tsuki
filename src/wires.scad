$fn = 30;

include <lib/BOSL2/std.scad>;
include <./vars.scad>;
include <./outline.scad>;

module row_wires(bez, N = 3) {
  down(diam / 2) linear_extrude(diam * 2) {
      for (i = [0:2])
        fwd(2.5 + cy * i)
          stroke(
            width=diam,
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

  // wells at the top of each column
  linear_extrude(2)for (i = [0:len(matrix[0]) - 1]) {
    key = matrix[0][i];
    echo(key);
    move([key[0], key[1] + 2.68 / 2]) move(column_offsets[i]) rect(3, rounding=1, anchor=[0, -1]);
  }

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

  wire = square([diam, diam], center=true);

  path_sweep2d(wire, points);
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
