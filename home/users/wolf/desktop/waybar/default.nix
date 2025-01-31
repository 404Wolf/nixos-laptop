{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
      mainBar = import ./bars/main.nix {inherit pkgs;};
      dateBar = import ./bars/peek.nix {inherit pkgs;};
    };
  };
}
