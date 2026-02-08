include <lib/BOSL2/std.scad>;
include <./vars.scad>;

far_x = 9 + diam / 2;
close_y = 3.8 - .08;
close_x = 4.3 + diam / 2;
far_y = 5.9;

column_wires();
row_wires();

for (point = flatten(matrix)) {
  color("red") move([point[0], point[1]]) circle(r=1);
}

matrix = [
  [points[14], points[11], points[8], points[5], points[2]],
  [points[13], points[10], points[7], points[4], points[1]],
  [points[12], points[9], points[6], points[3], points[0]],
  [points[16], points[15]],
];

module row_wires() {
  row_offsets = [
    [close_x, 5],
    [close_x, 5],
    [close_x, 5],
    [close_x, 5],
    [far_x, 10],
  ];

  for (i = [0:len(matrix) - 1]) {
    row_wire(matrix[i], row_offsets);
  }
}

module column_wires() {
  column_offsets = [
    [-far_x, -close_y],
    [-far_x, -close_y],
    [-far_x, -close_y],
    [close_x, -far_y],
    [-close_x, far_y],
  ];

  transposed_matrix = [
    for (j = [0:max([for (row = matrix) len(row)]) - 1]) [
      for (i = [0:len(matrix) - 1]) if (j < len(matrix[i])) matrix[i][j],
    ],
  ];

  for (i = [0:len(transposed_matrix) - 1]) {
    column_wire(transposed_matrix[i], column_offsets[i]);
  }
}

module row_wire(
  row,
  offsets
) {
  points =
  round_corners(
    [
      for (i = [0:len(row) - 1]) each if (i == 0) [
        // first
        solder_point(row[i], offsets[i], horiz=0),
        solder_point(row[i], offsets[i], horiz=12),
      ] else if (i == len(row) - 1) [
        // last
        solder_point(row[i], offsets[i], horiz=0),
        solder_point(row[i], offsets[i], horiz=4),
      ] else [
        solder_point(row[i], offsets[i], horiz=0),
        solder_point(row[i], offsets[i], horiz=12),
      ],
    ],
    closed=false,
    r=0
  );

  wire = square([diam, diam * 2], center=true);

  up(diam / 2) path_sweep2d(wire, points);
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

v_offset = 1.68 - diam / 2;
function solder_point(key, offset, vert = 0, horiz = 0) =
  zrot(
    a=key[2],
    cp=[key[0], key[1]],
    p=left(
      x=horiz, p=back(
        y=(v_offset * vert), p=move(
          v=offset,
          p=[key[0], key[1]]
        )
      )
    )
  );
