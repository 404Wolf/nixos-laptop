{config, ...}:
with config.colorScheme.palette; {
  programs.fzf = {
    enable = true;
    colors = with config.lib.stylix.colors.withHashtag; {
      "bg" = base00;
      "bg+" = base01;
      "fg" = base04;
      "fg+" = base06;
      "header" = base0D;
      "hl" = base0D;
      "hl+" = base0D;
      "info" = base0A;
      "marker" = base0C;
      "pointer" = base0C;
      "prompt" = base0A;
      "spinner" = base0C;
    };
  };
}
