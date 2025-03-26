{pkgs, ...}: {
  hardware.opengl = {
    package = pkgs.mesa.drivers;

    # if you also want 32-bit support (e.g for Steam)
    driSupport32Bit = true;
    package32 = pkgs.pkgsi686Linux.mesa.drivers;
  };
}
