{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        extraOptions = {
          AddKeysToAgent = "yes";
          Compression = "yes";
          ServerAliveInterval = "60";
          ServerAliveCountMax = "10";
        };
      };

      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
      };

      "wolf-pi" = {
        hostname = "100.73.116.57";
        forwardAgent = true;
        identityFile = "~/.ssh/id_rsa";
        user = "wolf";
      };
    };
  };
}
