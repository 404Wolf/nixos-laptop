{pkgs, ...}: {
  hardware.opengl = {
    driSupport32Bit = true;
    package32 = pkgs.pkgsi686Linux.mesa;
  };
}
