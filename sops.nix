{config, ...}: {
  sops.defaultSopsFile = ./secrets.yaml;

  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt";

  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;

  # This is the actual specification of the secrets
  sops.secrets =
    builtins.mapAttrs
    (name: value: {owner = config.users.users.wolf.name;} // value) {
      "accounts/wolfmermelstein_fastmail/app-password" = {};
      "accounts/wolfmermelstein_fastmail/password" = {};
      "accounts/wolfmermelstein_gmail/app-password" = {};
      "accounts/wolfmermelstein_gmail/password" = {};
      "accounts/wsm32_case/app-password" = {};
      "accounts/wsm32_case/password" = {};
      "accounts/pia_vpn/auth" = {};
      "remotes/windows/password" = {};
      "remotes/cloudflare/404wolf" = {};
      "api-keys/openai" = {};
      "api-keys/anthropic" = {};
      "api-keys/valtown" = {};
    };
}
