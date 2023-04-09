{
  description = "Go (language) developer tools";
  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    flake-utils.url = "flake:flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    overlays.url = "github:thelonelyghost/blank-overlay-nix";
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, overlays }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # config.allowUnfree = true;
          overlays = [overlays.overlays.default];
        };

        thelonelyghost = {
          name = "David Alexander";
          email = "opensource@thelonelyghost.com";
          github = "TheLonelyGhost";
          githubId = 1276113;
        };

        cobra-cli = import ./packages/cobra-cli {
          inherit pkgs thelonelyghost;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.bashInteractive
            pkgs.gnumake
            pkgs.statix
          ];
          buildInputs = [
          ];

          shellHook = ''
          export STATIX='${pkgs.statix}/bin/statix'
          '';
        };

        packages = {
          inherit cobra-cli;

          default = cobra-cli;
        };
      });
}
