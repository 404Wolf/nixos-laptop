{config, ...}: let
  path = "${config.xdg.dataHome}/wallpapers/wallpaper.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = path;
      wallpaper = ",${path}";
    };
  };
}
