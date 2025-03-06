{config, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Wolf Mermelstein";
    userEmail = "wolf@404wolf.com";
    signing = {
      key = "9EF8F7CF703D27A1230EBF96C09B8B22D90547F3"; # Primary yubikey
      signByDefault = true;
    };
    delta = {
      enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
    extraConfig = {
      init = {defaultBranch = "main";};
      global = {
        safe.directory = "*";
        core = {
          excludesfile = "${config.xdg.configHome}/git/ignore";
        };
      };
    };
  };
  programs.gh = {
    enable = true;
    settings = {git_protocol = "ssh";};
  };
  xdg.configFile."git/ignore".source = ./gitignore;
}
