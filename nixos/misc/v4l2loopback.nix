{pkgs, ...}: {
  # Load the v4l2loopback kernel module at boot
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];

  # Ensure the v4l2loopback module is available
  boot.extraModulePackages = [
    pkgs.linuxPackages.v4l2loopback
  ];

  # Configure the v4l2loopback module
  boot.extraModprobeConfig = ''
    # Set options for v4l2loopback:
    # - exclusive_caps=1: Exclusive access to the device
    # - video_nr=9: Create /dev/video9
    # - card_label="Virtual Camera": Set the name of the virtual device
    options v4l2loopback exclusive_caps=1 video_nr=9 card_label="Virtual Camera"
  '';

  # Install v4l-utils package for video4linux utilities
  environment.systemPackages = with pkgs; [v4l-utils];
}
