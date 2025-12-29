{config, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = "9EF8F7CF703D27A1230EBF96C09B8B22D90547F3"; # Primary yubikey
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Wolf Mermelstein";
        email = "wolf@404wolf.com";
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
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
    settings = {
      git_protocol = "ssh";
    };
  };

  xdg.configFile."git/ignore".source = ./gitignore;
}
