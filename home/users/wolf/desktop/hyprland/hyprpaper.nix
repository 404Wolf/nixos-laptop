{...}: let
  path = "~/.background-images/wallpaper.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = path;
      wallpaper = ",${path}";
    };
  };
}
