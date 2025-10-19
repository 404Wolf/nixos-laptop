{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber = {
      extraConfig.no-ucm = {
        enable = true;
        "monitor.alsa.properties" = {
          "alsa.use-ucm" = false;
        };
      };
    };
  };

  # https://chatgpt.com/share/68f545d2-be80-8004-a961-57c1a1386e18
  systemd.user.services.set-alsa-mixer = {
    # because I'm so good at fucking it up by mistake :/
    description = "Reset the microphone state on login";
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = [
      "${pkgs.alsa-utils}/bin/amixer -c 2 set Capture 63 cap"
      "${pkgs.alsa-utils}/bin/amixer -c 2 set 'Internal Mic' cap"
      "${pkgs.alsa-utils}/bin/amixer -c 2 set 'Internal Mic Boost' 2"
    ];
  };

  environment.etc."pulse/default.pa".text = ''
    .include /etc/pulse/default.pa
    set-default-sink alsa_output.pci-0000_c1_00.6.analog-stereo
  '';
}
