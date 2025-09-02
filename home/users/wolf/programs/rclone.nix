{osConfig, ...}: let
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

    mounts = builtins.listToAttrs (
      map (bucketName: {
        name = bucketName;
        value = {
          enable = true;
          mountPoint = "/mnt/R2/${bucketName}";
          options = {
            vfs-cache-mode = "full";
            vfs-cache-max-size = "10G";
            dir-cache-time = "5m";
          };
        };
      }) [
        "personal"
        "backups"
        "shares"
        "404wolf"
      ]
    );
  };
in {
  programs.rclone = {
    enable = true;
    remotes = {
      "r2" = r2Remote;
    };
  };
}
