{
  lib,
  modulesPath,
  ...
}: {
  # Import additional configuration files
  imports = [
    ./mounts.nix
    ./nvidia.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Kernel modules to be loaded in the initial ramdisk
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid"];

  # Kernel modules to be loaded by the kernel
  boot.kernelModules = ["kvm-intel" "usbserial" "ftdi_sio"];

  # Boot loader configuration
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
      configurationLimit = 10;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Network configuration
  networking.useDHCP = lib.mkDefault true;

  # Set the system architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.system = "x86_64-linux";

  # Allow yubikey-agent for using yubikey for ssh keys
  services.yubikey-agent.enable = true;
}
