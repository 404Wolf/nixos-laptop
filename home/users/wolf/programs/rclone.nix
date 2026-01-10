{
  pkgs,
  osConfig,
  ...
}: let
  mkRcloneMountUnits = {
    bucket,
    remote,
    mountPath,
  }: let
    name = "${bucket}@${remote}";
    mount-name = "rclone-mount-${name}";
  in {
    services.${mount-name} = {
      Unit = {
        Description = "Rclone FUSE daemon for ${remote}:${bucket}";
      };
      Service = {
        Type = "notify";
        ExecStartPre = pkgs.writeShellScript "rclone-mount-pre" ''
          mkdir -p ${mountPath} || true
          fusermount -u ${mountPath} 2>/dev/null || true
        '';
        ExecStart = pkgs.writeShellScript "rclone-mount-start" ''
          ${pkgs.rclone}/bin/rclone mount \
            --cache-dir %C/rclone \
            --dir-cache-time 5m \
            --vfs-cache-max-size 10G \
            --vfs-cache-mode full \
            ${remote}:${bucket} \
            ${mountPath}
        '';
        Restart = "on-failure";
        Environment = "PATH=/run/wrappers/bin";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
    services."rclone-healthcheck-${name}" = {
      Unit = {
        Description = "Health check for ${remote}:${bucket} mount";
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "rclone-healthcheck" ''
          # If we get something other than file not found, it prob means that the mount is broken
          stat ${mountPath}/$(uuidgen) 2>&1 | grep -q "No such file or directory"
        '';
        ExecStartPost = pkgs.writeShellScript "rclone-healthcheck-restart" ''
          if [ $EXIT_STATUS -ne 0 ]; then
            systemctl --user restart ${mount-name}.service
          fi
        '';
      };
    };
    timers."rclone-healthcheck-${name}" = {
      Unit = {
        Description = "Timer for health check of ${remote}:${bucket} mount";
      };
      Timer = {
        OnBootSec = "1m";
        OnUnitActiveSec = "1m";
        Unit = "rclone-healthcheck-${name}.service";
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
in {
  systemd.user = pkgs.lib.recursiveUpdate {} (
    builtins.foldl'
    (
      acc: bucket:
        pkgs.lib.recursiveUpdate acc (mkRcloneMountUnits {
          inherit bucket;
          remote = "r2";
          mountPath = "/mnt/r2/${bucket}";
        })
    )
    {}
    [
      "static"
      "personal"
      "backups"
      "shares"
    ]
  );

  programs.rclone = {
    enable = true;

    remotes.r2 = {
      config = {
        type = "s3";
        provider = "Cloudflare";
        endpoint = "";
      };

      secrets = {
        access_key_id = osConfig.sops.secrets."api-keys/cloudflare/personal-r2/access_key_id".path;
        secret_access_key = osConfig.sops.secrets."api-keys/cloudflare/personal-r2/secret_access_key".path;
        endpoint = osConfig.sops.secrets."api-keys/cloudflare/personal-r2/endpoint".path;
      };
    };
  };
}
