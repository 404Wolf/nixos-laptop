{
  pkgs,
  config,
  osConfig,
  ...
}: let
  r2Remote = {
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

  buckets = [
    "personal"
    "backups"
    "shares"
    "404wolf"
    "static"
  ];
in {
  programs.rclone = {
    enable = true;
    remotes = {
      "r2" = r2Remote;
    };
  };

  systemd.user.services = builtins.listToAttrs (
    map (bucket: {
      name = "rclone-mount-r2-${bucket}";
      value = {
        Unit = {
          Description = "Mount r2:${bucket} with rclone";
          Wants = ["network-online.target"];
          BindsTo = ["mnt-R2-${bucket}.mount"];
        };

        Service = {
          Type = "simple";
          ExecStart =
            "${pkgs.rclone}/bin/rclone mount r2:${bucket} /mnt/R2/${bucket} "
            + "--config=${config.xdg.configHome}/rclone/rclone.conf "
            + "--vfs-cache-mode=full "
            + "--vfs-cache-max-size=10G "
            + "--dir-cache-time=5m";
          ExecStop = "${pkgs.fuse}/bin/fusermount -u /mnt/R2/${bucket}";
          Restart = "on-failure";
          RestartSec = "10s";
        };

        Install = {
          WantedBy = ["default.target"];
        };
      };
    })
    buckets
  );

  systemd.user.mounts = builtins.listToAttrs (
    map (bucket: {
      name = "mnt-R2-${bucket}";
      value = {
        Unit.After = ["network-online.target"];

        Mount = {
          Type = "fuse";
          What = "rclone";
          Where = "/mnt/R2/${bucket}";
          Options = builtins.concatStringsSep "," [
            "rw"
            "nofail"
            "_netdev"
            "allow_other"
            "config=${config.xdg.configHome}/rclone/rclone.conf"
            "remote=r2:${bucket}"
            "vfs_cache_mode=full"
            "vfs_cache_max_size=10G"
            "dir_cache_time=5m"
          ];
        };

        Install = {
          WantedBy = ["default.target"];
        };
      };
    })
    buckets
  );

  systemd.user.automounts = builtins.listToAttrs (
    map (bucket: {
      name = "mnt-R2-${bucket}";
      value = {
        Unit = {
          Description = "Automount for r2:${bucket}";
          After = ["network-online.target"];
        };

        Automount = {
          Where = "/mnt/R2/${bucket}";
          TimeoutIdleSec = "600";
        };

        Install = {
          WantedBy = ["default.target"];
        };
      };
    })
    buckets
  );
}
