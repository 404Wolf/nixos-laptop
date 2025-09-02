{
  pkgs,
  config,
  osConfig,
  ...
}: {
  home.packages = with pkgs; [restic resticprofile];

  home.file."${config.xdg.configHome}/resticprofile/profiles.yaml".text = let
    yamlContent = builtins.readFile ./profiles.yaml;

    s3AccessKeyId = osConfig.sops.secrets."api-keys/cloudflare/personal-r2/access_key_id".path;
    s3SecretAccessKey = osConfig.sops.secrets."api-keys/cloudflare/personal-r2/secret_access_key".path;
    s3Endpoint = osConfig.sops.secrets."api-keys/cloudflare/personal-r2/endpoint".path;
  in
    builtins.replaceStrings
    ["{{S3_ACCESS_KEY_ID}}" "{{S3_SECRET_ACCESS_KEY}}" "{{S3_ENDPOINT}}"]
    [s3AccessKeyId s3SecretAccessKey s3Endpoint]
    yamlContent;
}
