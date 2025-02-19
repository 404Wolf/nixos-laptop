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
    sha256 = "sha256:11ij3k9725plcav0am5x69bqjr68n5ss6qyk154isk4rxasxb127";
  });

  # Create plugdev group
  users.groups.plugdev = {};

  # Add your user to the plugdev group
  users.users.wolf.extraGroups = ["plugdev"];
}
