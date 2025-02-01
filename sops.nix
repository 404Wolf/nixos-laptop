{
  sops.defaultSopsFile = ./secrets.yaml;

  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/home/wolf/.config/sops/age/keys.txt";

  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;

  # This is the actual specification of the secrets.
  sops.secrets."accounts/wolfmermelstein_fastmail/app-password" = {};
  sops.secrets."accounts/wolfmermelstein_fastmail/password" = {};
  sops.secrets."accounts/wolfmermelstein_gmail/app-password" = {};
  sops.secrets."accounts/wolfmermelstein_gmail/password" = {};
  sops.secrets."accounts/wsm32_case/app-password" = {};
  sops.secrets."accounts/wsm32_case/password" = {};
  sops.secrets."accounts/uptothebird_gmail/bitwarden-account" = {};
  sops.secrets."remotes/windows/password" = {};
  sops.secrets."api-keys/openai" = {};
  sops.secrets."api-keys/anthropic" = {};
}
