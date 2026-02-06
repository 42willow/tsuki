include <lib/BOSL2/std.scad>;

outline = path_join(
  [
    [[8, -1], [8, 53]],
    bezier_curve([[8, 53], [50, 90], [118, 53]]),
    [[117, 53], [117, 5]],
    [[117, 5], [103.5, -18.5]],
    bezier_curve([[103.5, -18.5], [70, 0], [8, -1]]),
  ],
  joint=[4, 4, 8, 4, 4],
  closed=true
);

outlines = union(
  outline,
  xflip(outline)
);
