{
  config,
  osConfig,
}: {
  home.files."${config.xdg.configHome}/obs-studio" = {
    enable = true;
    source = ../programs/obs;
    recursive = true;
  };
}
