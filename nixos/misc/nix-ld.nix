{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      glib
      openssl
      zlib
      bzip2
      libxml2
      libxslt
      readline
      ncurses
      cairo
      atk
      gdk-pixbuf
      freetype
      fontconfig
      libffi
      libcap
      libgcrypt
      libuuid
      libidn2
      libunistring
      libpsl
      libtasn1
      nettle
      p11-kit
      libsecret
    ];
  };
}
