{
  config,
  pkgs-unstable,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs-unstable.hyprpaper;

    settings = {
      preload = config.my.variables.wallpaper-path;
      wallpaper = ",${config.my.variables.wallpaper-path}";
    };
  };
}
