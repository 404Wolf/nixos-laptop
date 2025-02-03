{pkgs, ...}: {
  fonts = {
    fontconfig.enable = true;
    packages = [
      pkgs.fira-code
      pkgs.fira-code-symbols
      pkgs.font-awesome
      pkgs.liberation_ttf
      pkgs.mplus-outline-fonts.githubRelease
      pkgs.nerd-fonts.lilex
      pkgs.nerd-fonts.hack
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      pkgs.proggyfonts
      pkgs.cartographcf
    ];
  };
}
