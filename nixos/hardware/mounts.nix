{pkgs, ...}: {
  fileSystems.vault = {
    device = "/dev/disk/by-uuid/065f9566-c638-4517-97ed-978e38b54477";
    mountPoint = "/mnt/vault";
    options = [
      "noauto"
      "nofail"
      "x-systemd.idle-timeout=1min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  fileSystems.wolf-usb = {
    device = "/dev/disk/by-uuid/67BF-E0B4";
    mountPoint = "/mnt/wolf-usb";
    fsType = "exfat";
    options = [
      "noauto"
      "nofail"
      "rw"
      "users"
      "umask=000"
      "x-systemd.idle-timeout=1min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  services.udisks2.enable = true;

  environment.systemPackages = [pkgs.exfat];
}
