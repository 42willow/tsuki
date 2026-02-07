include <lib/BOSL2/std.scad>;
include <./vars.scad>;

far_x = 9 + diam / 2;
close_y = 3.8 - .08;
close_x = 4.3 + diam / 2;
far_y = 5.9;

module column_wires() {
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
