{
  services.pipewire.alsa.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      # enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    wireplumber.enable = true;
  };

  # In case I fuck it up:
  # https://chatgpt.com/share/68f545d2-be80-8004-a961-57c1a1386e18
  # amixer -c 2 set Capture 63 cap
  # amixer -c 2 set 'Internal Mic' cap
  # set-default-sink alsa_output.pci-0000_c1_00.6.analog-stereo
}
