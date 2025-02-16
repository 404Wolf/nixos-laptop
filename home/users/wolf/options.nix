{
  pkgs,
  config,
  ...
}: {
  my = {
    variables = {
      wallpaper-fetch-url = "https://wolf-fetchbingimageoftheday.web.val.run";
      wallpaper-path = config.xdg.dataHome + "/wallpapers/wallpaper.jpg";
    };
    scripts = let
      wallpaper-path = config.my.variables.wallpaper-path;
      wallpaper-backup-path = config.my.variables.wallpaper-path + ".backup";
      wallpaper-fetch-url = config.my.variables.wallpaper-fetch-url;
      hyprpaper = "${pkgs.hyprpaper}/bin/hyprpaper";
      curl = "${pkgs.curl}/bin/curl";
      cp = "${pkgs.coreutils}/bin/cp";
    in {
      wallpaper-refresh = pkgs.writeShellScript "wallpaper-refresh" ''
        # Create backup of current wallpaper
        ${cp} ${wallpaper-path} ${wallpaper-backup-path}

        # Download new wallpaper and store HTTP code
        HTTP_CODE=$(${curl} -w '%{http_code}' -L ${wallpaper-fetch-url} -o ${wallpaper-path})

        if [ "$HTTP_CODE" != "200" ]; then
          # Restore backup if download failed
          ${cp} ${wallpaper-backup-path} ${wallpaper-path}
        fi

        pkill "hyprpaper" && ${hyprpaper}
      '';
    };
  };
}
