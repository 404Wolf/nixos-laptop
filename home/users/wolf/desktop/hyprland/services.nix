{
  pkgs,
  config,
  ...
}: {
  systemd.user = {
    services.wallpaper-refresh = {
      Unit = {Description = "Refresh wallpaper";};
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "wallpaper-refresh" ''
          ${pkgs.curl}/bin/curl \
            -L ${config.my.variables.wallpaper-fetch-url} \
            -o ${config.my.variables.wallpaper-path}

          hyprctl hyprpaper reload ,"${config.my.variables.wallpaper-path}"

          ${pkgs.imagemagick}/bin/convert ${config.my.variables.wallpaper-path} -resize 800x600 ${config.my.variables.low-resolution-wallpaper-path}
        '';
      };
    };

    timers.wallpaper-refresh = {
      Unit = {Description = "Timer for refreshing wallpaper";};
      Timer = {
        OnBootSec = "1min";
        OnUnitActiveSec = "6h";
      };
      Install = {WantedBy = ["timers.target"];};
    };
  };
}
