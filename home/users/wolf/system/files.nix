{
  homeDirectory,
  pkgs,
  config,
  ...
}: {
  "${config.xdg.configHome}/gpt-cli/gpt.yml" = {
    enable = true;
    text = import ../utils/gpt.nix {inherit pkgs;};
  };
  "${homeDirectory}/.cookiecutterrc" = {
    text = builtins.toJSON {
      "default_context" = {
        "author_name" = "Wolf Mermelstein";
        "author_email" = "wolfmermelstein@gmail.com";
      };
    };
  };
}
