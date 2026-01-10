{
  pkgs,
  config,
  osConfig,
  ...
}: {
  home.packages = with pkgs; [
    restic
    resticprofile
  ];

  home.file."${config.xdg.configHome}/resticprofile/profiles.yaml".text = builtins.toJSON (
    import ./profiles.nix {inherit osConfig config;}
  );

  systemd.user.timers.resticprofile-setup = {
    Unit = {
      Description = "Setup resticprofile schedules";
    };
    Timer = {
      OnBootSec = "5min";
      Persistent = true;
    };
    Install = {
      WantedBy = ["timers.target"];
    };
  };

  systemd.user.services.resticprofile-setup = {
    Unit = {
      Description = "Setup resticprofile schedules";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.resticprofile}/bin/resticprofile schedule --all";
      RemainAfterExit = true;
    };
  };
}
