{pkgs, ...}: {
  services.yubikey-agent.enable = true;
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  hardware.gpgSmartcards.enable = true;

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  environment.etc."scdaemon.conf".text = ''
    reader-port Yubico Yubi
    disable-ccid
  '';

  services.udev.packages = [pkgs.yubikey-personalization];
  services.openssh.enable = true;

  programs.ssh = {
    enableAskPassword = true;
    askPassword = "QT_QPA_PLATFORM=\"wayland\" ${pkgs.kdePackages.ksshaskpass}";
  };

  environment.systemPackages = [pkgs.libfido2];

  # Add the FIDO2 udev rules directly from Yubico's repository
  services.udev.extraRules = builtins.readFile (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Yubico/libfido2/main/udev/70-u2f.rules";
    sha256 = "sha256:0cq1b9q5vn64lxv8q8jz81q48885rg51k1h3n2gn9qd2wbal6ldf";
  });

  # Create plugdev group
  users.groups.plugdev = {};

  # Add your user to the plugdev group
  users.users.wolf.extraGroups = ["plugdev"];
}
