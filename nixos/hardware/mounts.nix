{
  # Portable 1T drive
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

  # Add udev rules to trigger automount when the device is connected
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="065f9566-c638-4517-97ed-978e38b54477", TAG+="systemd", ENV{SYSTEMD_WANTS}="mnt-vault.automount"
  '';

  # Main drive with hibernate swap partition
  # swapDevices = [
  #   {
  #     device = "/dev/disk/by-uuid/ec3abbb3-bc82-4d75-bd4a-dc87833d4621";
  #     label = "main-drive-hibernate-swap";
  #   }
  # ];

  # Root filesystem configuration
  # fileSystems."/" = {
  #   device = "/dev/disk/by-uuid/81203b2b-f341-480f-a6b6-0480875f8acb";
  #   fsType = "btrfs";
  # };

  # LUKS encrypted device configuration
  # boot.initrd.luks.devices."luks-5521209e-ba18-40f6-b917-36202c56c63b".device = "/dev/disk/by-uuid/5521209e-ba18-40f6-b917-36202c56c63b";

  # Boot partition configuration
  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-uuid/62AC-8301";
  #   fsType = "vfat";
  #   options = ["fmask=0022" "dmask=0022"];
  # };
}
