{
  programs.thunderbird = {
    enable = true;
    settings = {
      "mailnews.wraplength" = 0;
      "mail.compose.default_to_paragraph" = false;
      "mail.compose.double_line_spacing" = false;
      "mailnews.default_sort_order" = 2;
    };
    profiles.primary = {
      isDefault = true;
      withExternalGnupg = true;
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
