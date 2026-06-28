include <../dist/points.scad>;

cx = 18;
cy = 17;
kx = cx - .5;
ky = cy - .5;

height = 5.5 - 2.20;
diam = 1.8; // wire diameter (actual 1.2)
gasket = [30, 3, 3];

screws = [
  [1.6 * cx, 2],
  [cx, 56],
  [114, 8],
  [114, 50.7],
];

far_x = 9 + diam / 2;
close_y = 3.8 - .08;
close_x = 4.3 + diam / 2;
far_y = 5.9;

// TODO right and left are when viewed from bottom, i.e. they are reversed

left_matrix = [
  [points[14], points[11], points[8], points[5], points[2]],
  [points[13], points[10], points[7], points[4], points[1]],
  [points[12], points[9], points[6], points[3], points[0]],
  [points[16], points[15]],
];

right_matrix = [
  [points[31], points[28], points[25], points[22], points[19]],
  [points[30], points[27], points[24], points[21], points[18]],
  [points[29], points[26], points[23], points[20], points[17]],
  [points[33], points[32]],
];

left_column_offsets = [
  [-far_x, -close_y],
  [-far_x, -close_y],
  [-far_x, -close_y],
  [close_x, -far_y],
  [-close_x, far_y],
];

right_column_offsets = [
  [close_x, -far_y],
  [close_x, -far_y],
  [close_x, -far_y],
  [close_x, -far_y],
  [-close_x, far_y],
];

mcu_size = [18, 34];
mcu_depth = 1.8;
mcu_pos = [108.5, 29];

charging_module_size = 9;
charging_module_pos = [points[8][0], 5];

// these are identical for each row, this just defined the top row
left_well_xs = [
  points[14][0] + close_x,
  points[11][0] + close_x,
  points[8][0] + close_x,
  points[5][0] - far_x,
];

right_well_xs = [
  points[19][0] + far_x,
  points[22][0] - far_x,
  points[25][0] - far_x,
  points[28][0] - far_x,
  points[31][0] - far_x,
];

left_row_bez = [
  [points[14][0] + close_x, points[14][1] + cy / 3],
  [points[11][0] - cx / 3, points[11][1] + cy / 3],
  [points[8][0] + cx / 3, points[8][1] + cy],
  [points[2][0] + far_x - diam, points[2][1] + cy * .9],
];

right_row_bez = [
  [points[19][0] + far_x - diam, points[19][1] - close_y],
  [points[25][0] + 6, points[19][1] - close_y],
  [points[25][0], 72],
  [points[25][0] - 6, points[19][1] - close_y],
  [points[31][0] - far_x + 3, points[31][1] - far_x],
];
