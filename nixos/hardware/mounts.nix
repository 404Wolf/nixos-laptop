{pkgs, ...}: {
  fileSystems.vault = {
    device = "/dev/disk/by-uuid/065f9566-c638-4517-97ed-978e38b54477";
    mountPoint = "/mnt/vault";
    options = [
      "noauto"
      "nofail"
      "x-systemd.automount"
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
      "x-systemd.automount"
      "x-systemd.idle-timeout=1min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  # Add a udev rule to trigger automount when the device is connected
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="065f9566-c638-4517-97ed-978e38b54477", TAG+="systemd", ENV{SYSTEMD_WANTS}="mnt-vault.automount"
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="065f9566-c638-4517-97ed-978e38b54477", TAG+="systemd", ENV{SYSTEMD_WANTS}="mnt-vault.automount"

    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="67BF-E0B4", TAG+="systemd", ENV{SYSTEMD_WANTS}="mnt-wolf-usb.automount"
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="67BF-E0B4", TAG+="systemd", ENV{SYSTEMD_WANTS}="mnt-wolf-usb.automount"
  '';

  # Ensure exfat support is available
  environment.systemPackages = [pkgs.exfat];
}
