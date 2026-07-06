{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bosl2 = {
      url = "github:BelfrySCAD/BOSL2/95acfd94d1d5159d384fa9eaa28700d49c44c83a";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    ergogenOverlay = final: prev: {
      ergogen = prev.ergogen.overrideAttrs (oldAttrs: rec {
        version = "4.3.0";
        src = final.fetchFromGitHub {
          owner = "ceoloide";
          repo = "ergogen";
          rev = "8528cab1b56f752148d4658a81fc960c57e9fc5b";
          hash = "sha256-hyi02Hk//xtCuPAqSAvQsSHcFPlo2TeBU6OgJbiMDjE=";
        };
        npmDepsHash = "sha256-s6tSACfLrkTXPWEkme38aFyq71bX7kXToIxJuyvmdR8=";
        npmDeps = final.fetchNpmDeps {
          name = "ergogen-${version}-npm-deps";
          src = src;
          hash = npmDepsHash;
        };
        doInstallCheck = false;
      });
    };

    forAllSystems = function:
      nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
        system: function (nixpkgs.legacyPackages.${system}.extend ergogenOverlay)
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
