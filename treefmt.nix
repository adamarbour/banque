{ pkgs, ... }:
{
  projectRootFile = ".git/config";

  programs.nixfmt.enable = true;
  programs.nixfmt.package = pkgs.nixfmt;

  programs.deadnix.enable = true;
  programs.statix.enable = true;

  # Shell
  programs.shfmt.enable = true;
  programs.shellcheck.enable = true;

  # misc
  programs.keep-sorted.enable = true;

  # exclude
  settings.global.excludes = [
    ".envrc"
    ".direnv/**"
    "result/**"
    "npins/**"
    "secrets/**"
  ];
}
