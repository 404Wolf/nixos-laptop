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

  # Install v4l-utils package for video4linux utilities
  environment.systemPackages = with pkgs; [v4l-utils];
}
