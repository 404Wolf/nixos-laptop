{config, ...}: {
  programs.go = {
    goPath = "${config.xdg.cacheHome}/go";
  };
}
