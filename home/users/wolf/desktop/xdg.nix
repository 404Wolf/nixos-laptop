{pkgs, ...}: {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "image/jpeg" = ["feh.desktop"];
        "hoppscotch" = ["hoppscotch-handler.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "text/html" = ["firefox.desktop"];
      };
    };
    desktopEntries = let
      mkFirefoxEntry = name: profile: {
        inherit name;
        genericName = "Web Browser";
        exec = "${pkgs.firefox-devedition}/bin/firefox --profile /home/wolf/mozilla/firefox/${profile} %U";
        terminal = false;
        categories = ["Application" "Network" "WebBrowser"];
        mimeType = ["text/html" "text/xml"];
      };
    in {
      firefox-primary = mkFirefoxEntry "Firefox Primary" "primary";
      firefox-school = mkFirefoxEntry "Firefox School" "school";
      feh = {
        name = "Feh";
        genericName = "Image Viewer";
        exec = "${pkgs.feh}/bin/feh %U";
        terminal = false;
        categories = ["Application" "Graphics" "Viewer"];
        mimeType = ["image/jpeg" "image/png"];
      };
    };
  };
}
