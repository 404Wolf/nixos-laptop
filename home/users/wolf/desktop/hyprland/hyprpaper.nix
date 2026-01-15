{config, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      wallpaper = {
        monitor = "";
        path = config.my.variables.wallpaper-path;
      };
    };
  };
}
