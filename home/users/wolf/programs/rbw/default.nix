{
  osConfig,
  pkgs,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "uptothebird@gmail.com";
      base_url = "https://vault.bitwarden.com";
      pinentry = pkgs.pinentry-qt;
    };
  };
}
