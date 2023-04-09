{ pkgs, thelonelyghost, ... }:

let
  version = "1.3.0";
  inherit (pkgs.lib) fakeSha256;
  # fakeSha256 = "sha256-${pkgs.lib.fakeSha256}";
in
pkgs.buildGoModule {
  pname = "cobra-cli";
  inherit version;

  patches = [
    ./test-year.patch
  ];

  src = pkgs.fetchFromGitHub {
    owner = "spf13";
    repo = "cobra-cli";
    rev = "v${version}";
    sha256 = "sha256-E0I/Pxw4biOv7aGVzGlQOFXnxkc+zZaEoX1JmyMh6UE=";
  };

  vendorSha256 = "sha256-vrtGPQzY+NImOGaSxV+Dvch+GNPfL9XfY4lfCHTGXwY=";

  meta = {
    description = "Cobra CLI tool to generate applications and commands";
    homepage = "https://cobra.dev/";
    license = pkgs.lib.licenses.mit;
    maintainers = [thelonelyghost];
  };
}
