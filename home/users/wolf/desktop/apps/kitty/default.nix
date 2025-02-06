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
        <<<<<<< HEAD
                map ctrl+shift+enter no_op
                map ctrl+shift+w no_op
                map ctrl+shift+] no_op
                map ctrl+shift+[ no_op
                map ctrl+shift+f no_op
                map ctrl+shift+b no_op
                map ctrl+shift+` no_op
                map ctrl+shift+1 no_op
                map ctrl+shift+2 no_op
                map ctrl+shift+3 no_op
                map ctrl+shift+4 no_op
                map ctrl+shift+5 no_op
                map ctrl+shift+6 no_op
                map ctrl+shift+7 no_op
                map ctrl+shift+8 no_op
                map ctrl+shift+9 no_op
                map ctrl+shift+0 no_op
                map ctrl+shift+l no_op
                map ctrl+shift+h no_op
                map ctrl+shift+k no_op
                map ctrl+shift+j no_op
                map ctrl+shift+q no_op
                map ctrl+shift+t no_op
                map ctrl+shift+alt+t no_op
        =======
                clear_all_shortcuts yes
        >>>>>>> ff0214d89cac02969c6cf0f15024828f5d5a6fd8
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
