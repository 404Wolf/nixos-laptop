{pkgs, ...}: {
  services.yubikey-agent.enable = true;
  services.pcscd.enable = true;

  services.udev.packages = [pkgs.yubikey-personalization];

  environment.systemPackages = [pkgs.libfido2];

  services.udev.extraRules = builtins.readFile (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Yubico/libfido2/main/udev/70-u2f.rules";
      sha256 = "sha256:0cq1b9q5vn64lxv8q8jz81q48885rg51k1h3n2gn9qd2wbal6ldf";
    }
  );

  users.groups.plugdev = {};
  users.users.wolf.extraGroups = ["plugdev"];
}
