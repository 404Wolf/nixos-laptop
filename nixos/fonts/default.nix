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
      (pkgs.stdenv.mkDerivation {
        name = "CartographCF";
        src = ./otfs;
        installPhase = ''
          mkdir -p $out/share/fonts
          cp *.otf $out/share/fonts
        '';
        meta = {
          description = "The Cartograph CF Font collection";
        };
      })
    ];
  };
}
