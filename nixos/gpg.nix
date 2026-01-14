{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnupg
  ];

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
}
