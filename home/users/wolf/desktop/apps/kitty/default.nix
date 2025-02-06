{
  config,
  helpers,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      enable_audio_bell = false;
      font_family = "FiraCode";
      font_size = 12;
      enable_ligatures = "always";
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
    };
    extraConfig =
      ''
        clear_all_shortcuts yes
      ''
      + (helpers.template ./template.mustache {
        inherit
          (config.colorScheme.palette)
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
          ;
      });
  };
}
