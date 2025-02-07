{config, ...}: let
  wallpaper = "${config.xdg.dataHome}/wallpapers/wallpaper.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wallpaper;
      wallpaper = ",${wallpaper}";
    };
  };
}
