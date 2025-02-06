{...}: let
  remote-builder-name = "wolf-desktop";

  # Desktop ssh configuration
  sshConfigText = ''
    Host ${remote-builder-name}
      HostName 100.94.255.80
      Port 22
      IdentityFile /home/wolf/.ssh/id_ed25519
      StrictHostKeyChecking=accept-new
  '';
in {
  programs.ssh.extraConfig = sshConfigText;

  # Setup openssh for sshing into desktop server
  services.openssh = {
    enable = true;
    settings = {
      AuthorizedKeysFile = "%h/.ssh/authorized_keys %h/.ssh/*.pub";
    };
  };

  # Remote builder is desktop
  nix.buildMachines = [
    # {
    #   hostName = "nixremote@${remote-builder-name}";
    #   system = "x86_64-linux";
    #   protocol = "ssh";
    #   maxJobs = 3;
    #   speedFactor = 3;
    #   supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    #   mandatoryFeatures = [];
    # }
  ];
  nix.distributedBuilds = true;

  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
