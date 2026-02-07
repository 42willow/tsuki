include <../dist/points.scad>;

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
