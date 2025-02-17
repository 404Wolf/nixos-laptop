{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = config.my.variables.wallpaper-path;
      wallpaper = ",${config.my.variables.wallpaper-path}";
    };
  };
}
