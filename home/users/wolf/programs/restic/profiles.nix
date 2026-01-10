{
  osConfig,
  config,
}: let
  mkInjectEnv = name: {
    run-before = [
      ''
        cat > /tmp/resticprofile-${name}.env << EOF
        AWS_ACCESS_KEY_ID=$(cat ${
          osConfig.sops.secrets."api-keys/cloudflare/personal-r2/access_key_id".path
        })
        AWS_SECRET_ACCESS_KEY=$(cat ${
          osConfig.sops.secrets."api-keys/cloudflare/personal-r2/secret_access_key".path
        })
        RESTIC_REPOSITORY=s3:$(cat /run/secrets/api-keys/cloudflare/personal-r2/endpoint)/backups/${name}
        EOF
      ''
    ];
    run-after = [
      ''rm /tmp/resticprofile-${name}.env''
    ];
    env-file = "/tmp/resticprofile-${name}.env";
  };
in {
  version = "2";

  global = {
    prevent-sleep = true;
    initialize = true;
    command-output = "auto";
  };

  profiles = {
    base = {
      password-file = "/run/secrets/other/restic/password";
      verbose = 2;
      backup = {
        exclude-caches = true;
      };
      forget = {
        keep-daily = 14;
        keep-weekly = 9;
        keep-monthly = "unlimited";
        keep-within = "30d";
        prune = true;
      };
    };

    framework =
      mkInjectEnv "framework"
      // {
        lock = "/tmp/resticprofile-framework.lock";
        "inherit" = "base";
        log = "${config.xdg.stateHome}/resticprofile-framework.log";
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
          schedule = ["daily"];
        };
        forget.schedule = ["weekly"];
        check.schedule = ["weekly"];
      };

    vault =
      mkInjectEnv "vault"
      // {
        lock = "/tmp/resticprofile-vault.lock";
        "inherit" = "base";
        log = "${config.xdg.stateHome}/resticprofile-vault.log";
        backup = {
          source = [
            "/home/wolf/Vault"
          ];
          exclude = [
            "/**/.direnv"
            "/**/.cache"
            "/**/node_modules"
          ];
          schedule = ["daily"];
        };
        forget.schedule = ["weekly"];
        check.schedule = ["weekly"];
      };
  };
}
