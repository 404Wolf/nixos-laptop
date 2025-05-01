{pkgs, ...}: {
  fonts = {
    fontconfig.enable = true;
    packages = [
      pkgs.fira-code
      pkgs.fira-code-symbols
      pkgs.font-awesome
      pkgs.liberation_ttf
      pkgs.mplus-outline-fonts.githubRelease
      pkgs.noto-fonts
      pkgs.nerdfonts
      pkgs.noto-fonts-emoji
      pkgs.proggyfonts
      pkgs.cartographcf
    ];
  };
}
