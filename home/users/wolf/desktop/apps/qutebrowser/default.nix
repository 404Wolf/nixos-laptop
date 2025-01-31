{
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      "DEFAULT" = "https://www.google.com/search?hl=en&q={}";
      "w" = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
    };
    keyBindings = {
      normal = {
        "<Alt-c>" = "tab-close";
        "<<" = "tab-move -";
        ">>" = "tab-move +";
        "L" = "navigate next";
      };
    };
  };
}
