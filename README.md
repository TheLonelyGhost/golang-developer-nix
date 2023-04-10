# Nix Flake: Go Tooling

A Nix Flake that contains software packages for developing applications in the [Go language](https://go.dev/).

Packages included:

- [`cobra-cli`](https://github.com/spf13/cobra-cli) (default package)

## Usage

### With Flakes

Add this repo to your `flake.nix` inputs like:

```nix
{
  # ...
  inputs.golang-developer.url = "github:thelonelyghost/golang-developer-nix";
  # ...

  outputs = { self, nixpkgs, flake-utils, golang-developer, ...}@attrs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      godev = golang-developer.packages."${system}";
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.bashInteractive
          godev.cobra-cli
        ];
      };
    });
}
```

**Updating:** Anytime you want to update what workstation-deps offers, run `nix flake lock --update-input golang-developer` and rebuild your Nix expression acccordingly.

### Without Flakes

If you're not yet using [Nix Flakes][flakes], such as with [`home-manager`][home-manager], here's how you can include it:

1. Install [`niv`][niv] and run `niv init`
2. Run `niv add thelonelyghost/golang-developer-nix --name golang-developer`
3. Include the following in your code:

```nix
{ lib, config, ... }:

let
  sources = import ./nix/sources.nix {};
  pkgs = import sources.nixpkgs {};

  godev = (import (pkgs.fetchFromGitHub { inherit (sources.golang-developer) owner repo rev sha256; })).outputs.packages."${builtins.currentSystem}";
in
{
  home.packages = [
    godev.cobra-cli
  ];
}
```

**Updating:** Anytime you want to update what golang-developer-nix offers, run `niv update golang-developer` and rebuild your Nix expression acccordingly.

[flakes]: https://github.com/NixOS/nix/blob/master/src/nix/flake.md
[home-manager]: https://github.com/nix-community/home-manager
[niv]: https://github.com/nmattia/niv
