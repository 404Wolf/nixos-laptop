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

    framework =
      mkInjectEnv "framework"
      // {
        lock = "/tmp/resticprofile-framework.lock";
        "inherit" = "base";
        run-after = [
          "rm /tmp/resticprofile-framework.env"
        ];
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

    vault =
      mkInjectEnv "vault"
      // {
        lock = "/tmp/resticprofile-vault.lock";
        "inherit" = "base";
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
