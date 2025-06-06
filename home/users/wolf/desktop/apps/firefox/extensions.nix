{pkgs}: let
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
  buildFirefoxXpiAddon = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon;
in
  [
    firefox-addons.multi-account-containers
    firefox-addons.ublock-origin
    firefox-addons.bitwarden
    firefox-addons.clearurls
    firefox-addons.firenvim
    firefox-addons.i-dont-care-about-cookies
  ]
  ++ [
    (pkgs.stdenv.mkDerivation rec {
      name = "bypass-paywalls-custom";
      version = "1.0";
      src = ./bypass-paywalls.xpi;
      preferLocalBuild = true;
      allowSubstitutes = true;
      passthru = {
        addonId = "bypasspaywalls@bypasspaywalls";
      };
      meta = with pkgs.lib; {
        homepage = "https://github.com/iamadamdev/bypass-paywalls-chrome";
        description = "Bypass Paywalls for various news sites";
        license = licenses.mit;
        platforms = platforms.all;
      };
      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${passthru.addonId}.xpi"
      '';
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
