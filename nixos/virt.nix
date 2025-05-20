{pkgs, ...}: {
  # Virtualization settings
  virtualisation = {
    podman.enable = true;
    docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      enable = true;
      storageDriver = "btrfs";
    };

    # libvirt configuration for managing virtual machines
    libvirtd = {
      enable = true;
      qemu = {
        # Enable swtpm for software TPM emulation
        swtpm.enable = true;
        # Enable OVMF for UEFI support in VMs
        ovmf.enable = true;
        # Use the full OVMF package
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    # Enable USB redirection for SPICE
    spiceUSBRedirection.enable = true;
  };

  # Enable SPICE agent for better integration with VMs
  services.spice-vdagentd.enable = true;

  # Enable dconf, which is required by some GNOME applications
  programs.dconf.enable = true;

  # Add necessary packages to the system environment
  environment.systemPackages = with pkgs; [
    virt-manager # GUI for managing virtual machines
    virt-viewer # Viewer for VMs using the SPICE protocol
    spice # Remote-access technology for virtual environments
    spice-gtk # GTK client and libraries for SPICE
    spice-protocol # SPICE protocol headers
    win-virtio # VirtIO drivers for Windows guests
    win-spice # SPICE drivers for Windows guests
    docker-compose # Tool for defining and running multi-container Docker applications
    podman-compose # Docker Compose-compatible CLI plugin for Podman
  ];
}
