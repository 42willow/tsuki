{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bosl2 = {
      url = "github:BelfrySCAD/BOSL2/95acfd94d1d5159d384fa9eaa28700d49c44c83a";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
        system: function nixpkgs.legacyPackages.${system}
      );
  in {
    packages = forAllSystems (pkgs: {
      default = pkgs.callPackage ./nix/package.nix {
        src = ./.;
        inherit inputs;
      };
    });
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          ergogen
          openscad-unstable
        ];
      };
    });
  };
}
