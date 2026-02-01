{
  sources ? import ./npins,
  system ? builtins.currentSystem,
}:
let
  shellsDir = ./shells;

  pkgs = import sources.nixpkgs { inherit system; };

  # numtide/treefmt-nix
  treefmtNix = import sources.treefmt-nix;
  treefmtWrapper = treefmtNix.mkWrapper pkgs (import ./treefmt.nix);

  # numtide/devshell setup
  devshell = import sources.devshell {
    inherit system;
    nixpkgs = pkgs;
  };
  mkShell =
    name:
    let
      base = devshell.fromTOML (shellsDir + "/${name}.toml");
    in
    pkgs.mkShell {
      inputsFrom = [ base ];
      packages = [ treefmtWrapper ];
    };
in
{
  inherit sources pkgs;
  # expose treefmt
  treefmt.wrapper = treefmtWrapper;
  # expose shells
  devShell = mkShell "default";
}
