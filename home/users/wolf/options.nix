{config, ...}: {
  my = {
    variables = {
      wallpaper-path = "${config.xdg.dataHome}/wallpapers/wallpaper.png";
      gpg-key-sec-id = "ed25519";
    };
  };
}
