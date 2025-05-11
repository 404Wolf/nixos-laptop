{
  config,
  pkgs,
  ...
}: {
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
        "x-scheme-handler/http" = ["firefox-primary.desktop"];
        "x-scheme-handler/https" = ["firefox-primary.desktop"];
        "text/html" = ["chromium-browser.desktop"];
      };
    };
    desktopEntries = {
      firefox-primary = {
        name = "Firefox Developer Edition";
        genericName = "Web Browser";
        exec = "${config.my.variables.firefox-package} --profile /home/wolf/.mozilla/firefox/primary/ %U";
        terminal = false;
        noDisplay = true;
        categories = ["Application" "Network" "WebBrowser"];
        mimeType = ["text/html" "text/xml"];
      };
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
