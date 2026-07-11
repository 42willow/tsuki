{
  stdenv,
  src,
  pkgs,
  inputs,
}:
stdenv.mkDerivation {
  pname = "tsuki";
  version = "0.1.0";
  inherit src;

  nativeBuildInputs = with pkgs; [
    ergogen
    yq-go
    jq
    openscad-unstable
  ];

  installPhase = ''
    mkdir -p "$out" dist

    ergogen hardware/ --debug --output dist

    points=$(yq eval -o=json dist/points/points.yaml \
      | jq '[.[] | [.x, .y, .r]]')
    printf "points = %s;\n" "$points" > dist/points.scad

    cp -r hardware/cad/* dist/
    mkdir -p dist/lib
    cp -r ${inputs.bosl2} dist/lib/BOSL2

    for f in plate case; do
      (cd dist && openscad-unstable -o "$out/$f.stl" "$f.scad")
    done

    (cd dist && openscad-unstable -o "$out/cover.dxf" cover.scad)

    cp -r dist "$out/"
  '';
}
