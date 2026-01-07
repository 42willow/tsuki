import * as Bun from "bun";
import { parse } from "yaml";
import path from "path";

type Key = {
  x: number;
  y: number;
  r: number;
  meta: object;
};

const __dirname = path.dirname(new URL(import.meta.url).pathname);
const inputPath = path.join(__dirname, "..", "dist", "points", "points.yaml");
export const input = parse(await Bun.file(inputPath).text());

// console.log(input);
let points: [number, number, number][] = [];

for (const pos of Object.values(input as Record<string, Key>)) {
  points.push([pos.x, pos.y, pos.r]);
}

console.log(JSON.stringify(points));
