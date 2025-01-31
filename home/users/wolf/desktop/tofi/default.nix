{config, ...}: (with config.colorScheme.palette; {
  programs.tofi = {
    enable = true;
    settings = {
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 9;

      # Font Configuration
      font = "monospace";
      font-size = 14;

      # Color Configuration
      text-color = "#${base05}";
      selection-color = "#${base0A}";
      selection-match-color = "#${base0B}";

      # Border Colors
      border-color = "#${base01}";
      outline-color = "#${base03}";

      # Prompt Configuration
      prompt-color = "#${base0C}";

      # Input Configuration
      input-color = "#${base05}";
      input-background = "#${base01}";

      # Selection Configuration
      selection-background = "#${base02}";

      # Matching Configuration
      fuzzy-match = true;

      # Miscellaneous
      hide-cursor = true;
      history = true;
    };
  };
})
