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
      wallpaper-fetch-url = config.my.variables.wallpaper-fetch-url;
      hyprpaper = "${pkgs.hyprpaper}/bin/hyprpaper";
      curl = "${pkgs.curl}/bin/curl";
    in {
      wallpaper-refresh = pkgs.writeShellScript "wallpaper-refresh" ''
        ${curl}/bin/curl -L ${wallpaper-fetch-url} -o ${wallpaper-path}
        pkill ${hyprpaper}/bin/hyprpaper && ${hyprpaper}/bin/hyprpaper
      '';
    };
  };
}
