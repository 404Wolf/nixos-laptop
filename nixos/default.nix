{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./audio.nix
    ./battery.nix
    ./fonts.nix
    ./hardware
    ./misc
    ./network.nix
    ./pam.nix
    ./nix.nix
    ./printing.nix
    ./remotes.nix
    ./users.nix
    ./virt.nix
    ./programs.nix
    (inputs.nix-index-database.nixosModules.nix-index)
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-qt;

  time.timeZone = "America/New_York";

  boot = {
    extraModulePackages = [
      config.boot.kernelPackages.acpi_call
    ];
    kernelModules = ["acpi_call"];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 10;
  };

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

  environment = {
    variables = {
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
      FZF_BASE = "${pkgs.fzf}/bin/fzf";
      EDITOR = "zeditor";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      TERM = "xterm-256color";
    };
  };

  programs = {
    nix-index-database.comma.enable = true;
    dconf.enable = true;
    zsh.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  security.rtkit.enable = true;

  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    dev.enable = true;
  };

  environment.systemPackages = [
    pkgs.man-pages
    pkgs.man-pages-posix
  ];

  security.pki.certificates = pkgs.lib.mkDefault [];

  security.pki.certificateFiles = [
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  ];

  system.stateVersion = "23.11";
}
