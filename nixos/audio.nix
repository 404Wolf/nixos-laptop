{
  hardware.pulseaudio.enable = false;

  # Enable and configure PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # Bluetooth manager
  services.blueman.enable = true;
}
