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

  systemd.user.services.waybar = {
    Unit = {
      Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors.";
      Documentation = "man:waybar(5)";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.waybar}/bin/waybar";
      ExecReload = "kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      Slice = "app-graphical.slice";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
