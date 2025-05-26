{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "wolf-desktop" = {
        hostname = "100.94.255.80";
        port = 22;
        identityFile = "~/.ssh/windows-nix";
        forwardAgent = true;
        user = "wolf";
        extraOptions = {
          StrictHostKeyChecking = "accept-new";
        };
      };

      "wolf-desktop-nix-builder" = {
        hostname = "100.94.255.80";
        port = 22;
        identitiesOnly = true;
        user = "nixremote";
        identityFile = "~/.ssh/windows-nix";
        extraOptions = {
          StrictHostKeyChecking = "accept-new";
        };
      };

      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
      };

      "lampi-ec2" = {
        hostname = "54.85.48.107";
        forwardAgent = true;
        identityFile = "~/.ssh/primary.pem";
        user = "ubuntu";
      };

      "lampi-pi" = {
        hostname = "100.83.60.41";
        forwardAgent = true;
        identityFile = "~/.ssh/id_rsa";
        user = "pi";
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
