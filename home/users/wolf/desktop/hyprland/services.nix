{
  config,
  pkgs,
  ...
}: {
  systemd.user = {
    services.wallpaper-refresh = {
      Unit = {Description = "Refresh wallpaper";};
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "wallpaper-refresh-then-hyprpaper" ''
          ${config.my.scripts.wallpaper-refresh}
          sleep 2
          pkill ${pkgs.hyprpaper}/bin/hyprpaper
          ${pkgs.hyprpaper}/bin/hyprpaper
        '';
      };
    };

    timers.wallpaper-refresh = {
      Unit = {Description = "Timer for refreshing wallpaper";};
      Timer = {
        OnBootSec = "1min";
        OnUnitActiveSec = "6h";
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
