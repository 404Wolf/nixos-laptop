{config, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      wallpaper = {
        monitor = "";
        path = config.my.variables.wallpaper-path;
      };
    };
  };
}
