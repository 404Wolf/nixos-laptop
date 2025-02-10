{pkgs, ...}: {
  programs.waybar = let
    scripts = import ./bars/scripts.nix {inherit pkgs;};
  in {
    enable = true;
    style = ./waybar.css;
    settings = {
      mainBar = import ./bars/main.nix {inherit pkgs scripts;};
      dateBar = import ./bars/peek.nix {inherit pkgs scripts;};
    };
  };
}
