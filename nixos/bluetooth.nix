{
  # Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      ReconnectAttempts = 0; # don't reconnect disconnected devices
    };
  };

  # Bluetooth manager
  services.blueman.enable = true;
}
