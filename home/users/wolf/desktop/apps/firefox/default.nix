{
  pkgs,
  lib,
  ...
}: rec {
  my.variables.firefox-package = "firefox-devedition";

  home.activation = {
    rmFirefoxJunk = lib.hm.dag.entryAfter ["writeBoundary"] ''
      rm -f rm /home/wolf/.mozilla/firefox/primary/search.json.mozlz4
    '';
  };

  programs.firefox = {
    enable = true;
    package = pkgs.${my.variables.firefox-package};
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      DisableAccounts = false;
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "seperate"; # alternative: "separate"
    };
    profiles = {
      primary = {
        isDefault = true;
        name = "Primary";
        id = 0;
        userChrome = builtins.readFile ./userChrome.css;
        settings = import ./settings.nix;
        extensions.packages = import ./extensions.nix {inherit pkgs;};
        search.order = [
          "ddg"
          "google"
        ];
        containersForce = true;
        containers = {
          Valtown = {
            id = 1;
            color = "turquoise";
            icon = "circle";
          };
          Case = {
            id = 2;
            color = "red";
            icon = "circle";
          };
          Tinkering = {
            id = 3;
            color = "green";
            icon = "circle";
          };
        };
      };
    };
  };
}
