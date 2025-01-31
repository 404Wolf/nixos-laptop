{
  imports = [./hibernate.nix];

  services.thermald.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  programs.xss-lock = {enable = true;};

  services = {
    logind.powerKey = "lock";
    logind.powerKeyLongPress = "hibernate";
    logind.lidSwitch = "suspend";
  };
}
