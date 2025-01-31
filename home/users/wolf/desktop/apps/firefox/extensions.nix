{pkgs}: let
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
  buildFirefoxXpiAddon = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon;
in
  [
    firefox-addons.ublock-origin
    firefox-addons.bitwarden
    firefox-addons.clearurls
    firefox-addons.i-dont-care-about-cookies
  ]
  ++ [
    (buildFirefoxXpiAddon {
      pname = "bypass-paywalls-clean";
      version = "3.9.6.0";
      addonId = "magnolia@12.34";
      url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-3.9.6.0.xpi&inline=false&commit=890c7ab6c601575754c615e7794e7dcfe58edcee";
      sha256 = "sha256-h/T76AZYOWUnrb/N9yDLWl0H6sxODArXP2dU0OIDijw=";
      meta = with pkgs.lib; {
        homepage = "https://twitter.com/Magnolia1234B";
        description = "Bypass Paywalls of (custom) news sites";
        license = licenses.mit;
        platforms = platforms.all;
      };
    })
    (buildFirefoxXpiAddon {
      pname = "browser-zoom";
      version = "1.0";
      addonId = "{daef88de-f4dd-4359-997c-b0c1eee0e5bb}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4305698/browser_zoom-1.0.xpi";
      sha256 = "sha256-6bFfbuCID2hakHm5LOze14GMc3LDcTHTdArgPZ98Ggc=";
      meta = with pkgs.lib; {
        homepage = "https://github.com/404wolf/Browser-Zoom";
        description = "Force Zoom to run in browser and skip past pesky popups";
        license = licenses.mit;
        platforms = platforms.all;
      };
    })
    (buildFirefoxXpiAddon {
      pname = "defund-wikipedia";
      version = "1.2";
      addonId = "defund-wikipedia@12.34";
      url = "https://addons.mozilla.org/firefox/downloads/file/3617936/defund_wikipedia-1.2.xpi";
      sha256 = "sha256-szWF1MEN1ixSwaM2CCAHTOjKo9X6g69X9ixSURUebRc=";
      meta = with pkgs.lib; {
        homepage = "https://github.com/kritikaseen/defund-wikipedia";
        description = "Defund wikipedia";
        license = licenses.mit;
        platforms = platforms.all;
      };
    })
  ]
