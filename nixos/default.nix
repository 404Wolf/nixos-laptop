{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    # ./kubernetes.nix
    ./audio.nix
    ./hardware
    ./misc
    ./fonts.nix
    ./network.nix
    ./virt.nix
    ./remotes.nix
    ./battery.nix
    ./users.nix
    ./pam.nix
    ./wayland.nix
    ./printing.nix
    (inputs.nix-index-database.nixosModules.nix-index)
  ];

  # Clock time
  time.timeZone = "America/New_York";

  # Hardware configuration
  boot = {
    extraModulePackages = [config.boot.kernelPackages.acpi_call];
    kernelModules = ["acpi_call"];
  };

  # System configuration
  zramSwap = {
    enable = true;
    memoryPercent = 10;
  };

  # Nix configuration
  nix.settings = {
    auto-optimise-store = true;
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    trusted-users = ["root" "wolf"];
    experimental-features = ["nix-command" "flakes"];
  };

  # Localization
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Environment variables
  environment = {
    variables = {
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
      FZF_BASE = "${pkgs.fzf}/bin/fzf";
      EDITOR = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      TERM = "xterm-256color";
    };
  };

  # Programs
  programs = {
    nix-index-database.comma.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Security
  security.rtkit.enable = true;

  # Documentation
  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    dev.enable = true;
  };

  system.stateVersion = "23.11";
}
