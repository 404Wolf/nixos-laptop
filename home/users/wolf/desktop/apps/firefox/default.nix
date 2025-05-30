{
  pkgs,
  pkgs-unstable,
  ...
}: rec {
  my.variables.firefox-package = "firefox-devedition";

  programs.firefox = {
    enable = true;
    package = pkgs-unstable.${my.variables.firefox-package};
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
          "Google"
          "NixOS-Wiki"
          "NixOS-Pkgs"
        ];
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "NixOS Wiki" = {
            urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };
        };
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
