{
  osConfig,
  config,
}:
{
  version = "2";

  global = {
    prevent-sleep = true;
    initialize = true;
    command-output = "auto";
    log = "${config.xdg.stateHome}/resticprofile.log";
  };

  profiles = {
    base = {
      password-file = "/run/secrets/other/restic/password";
      verbose = 2;
      backup = {
        exclude-caches = true;
      };
    };

    laptop = {
      lock = "/tmp/resticprofile-laptop.lock";
      "inherit" = "base";
      run-before = [
        "export AWS_ACCESS_KEY_ID=$(cat ${
          osConfig.sops.secrets."api-keys/cloudflare/personal-r2/access_key_id".path
        })"
        "export AWS_SECRET_ACCESS_KEY=$(cat ${
          osConfig.sops.secrets."api-keys/cloudflare/personal-r2/secret_access_key".path
        })"
        ''export RESTIC_REPOSITORY="s3:$(cat /run/secrets/api-keys/cloudflare/personal-r2/endpoint)/backups/laptop"''
      ];
      retention = {
        keep-hourly = 1;
        keep-daily = 30;
        keep-weekly = 25;
        keep-monthly = 9999;
        keep-yearly = 9999;
      };
      backup = {
        source = [
          "/home/wolf"
        ];
        exclude = [
          "/**/.direnv"
          "/**/.cache"
          "/**/node_modules"
          "/**/.local/share/Trash"
          "/**/.local/share/Steam/.*"
          "/home/wolf/Vault/**"
        ];
      };
    };

    vault = {
      lock = "/tmp/resticprofile-vault.lock";
      "inherit" = "base";
      run-before = [
        "export AWS_ACCESS_KEY_ID=$(cat ${
          osConfig.sops.secrets."api-keys/cloudflare/personal-r2/access_key_id".path
        })"
        "export AWS_SECRET_ACCESS_KEY=$(cat ${
          osConfig.sops.secrets."api-keys/cloudflare/personal-r2/secret_access_key".path
        })"
        ''export RESTIC_REPOSITORY="s3:$(cat /run/secrets/api-keys/cloudflare/personal-r2/endpoint)/backups/vault"''
      ];
      retention = {
        keep-hourly = 3;
        keep-daily = 30;
        keep-weekly = 9999;
        keep-monthly = 9999;
        keep-yearly = 9999;
      };
      backup = {
        source = [
          "/home/wolf/Vault"
        ];
        exclude = [
          "/**/.direnv"
          "/**/.cache"
          "/**/node_modules"
        ];
      };
    };
  };
}
