{config, ...}: {
  my = {
    variables = {
      wallpaper-fetch-url = "https://wolf-fetchbingimageoftheday.web.val.run";
      wallpaper-path = config.xdg.dataHome + "/wallpapers/wallpaper.jpg";
      primary-yubikey-gpg-id = "0FAA8CC4BEA2720A";
    };
  };
}
