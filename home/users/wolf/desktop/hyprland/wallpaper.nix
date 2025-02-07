{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.fetch-bing-wallpaper = {
    Unit = {
      Description = "Fetch Bing wallpaper of the day";
      After = "network-online.target";
      Wants = "network-online.target";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.curl}/bin/curl -L https://wolf-fetchbingimageoftheday.web.val.run -o ${config.xdg.dataHome}/wallpapers/wallpaper.jpg";
    };
  };

  # Add a timer to run it daily
  systemd.user.timers.fetch-bing-wallpaper = {
    Unit = {
      Description = "Fetch Bing wallpaper of the day timer";
    };

    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };

  # Ensure the wallpapers directory exists
  systemd.user.tmpfiles.rules = [
    "d ${config.xdg.dataHome}/wallpapers 0755 wolf users"
  ];
}
