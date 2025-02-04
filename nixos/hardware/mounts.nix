{
  pkgs,
  config,
  ...
}: {
  # Configure my Portable 1T drive

  # Set up the filesystem mount
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

  # Add a udev rule to trigger automount when the device is connected
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="065f9566-c638-4517-97ed-978e38b54477", TAG+="systemd", ENV{SYSTEMD_WANTS}="mnt-vault.automount"
  '';

  # Set up valfs file system
  system.activationScripts = {
    createValfsMount = ''
      mkdir -p /mnt/valfs
      chown wolf:users /mnt/valfs
    '';
  };
  systemd.services.valfs = {
    description = "Mount valfs";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    path = with pkgs; [valfs fuse deno coreutils];
    serviceConfig = {
      Type = "simple";
      User = "wolf";
      ExecStartPre = pkgs.writeShellScript "valfs-pre" ''
        ${pkgs.coreutils}/bin/mkdir -p /mnt/valfs
      '';
      ExecStart = pkgs.writeShellScript "mount-valfs" ''
        export PATH=${pkgs.fuse}/bin:/run/wrappers/bin/:$PATH
        VAL_TOWN_API_KEY="$(cat ${config.sops.secrets."api-keys/valtown".path})"
        export VAL_TOWN_API_KEY
        ${pkgs.valfs}/bin/valfs mount /mnt/valfs --verbose
      '';
      Restart = "on-failure";
      RemainAfterExit = true;
    };
  };
}
