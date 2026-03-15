{...}: {
  services.openssh = {
    enable = true;
    openFirewall = false; # Only expose SSH via Tailscale
    settings = {
      AuthorizedKeysFile = "%h/.ssh/authorized_keys";
    };
  };

  # Allow SSH only on the Tailscale interface
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [22];

  services.tailscale = {
    openFirewall = true;
  };
}
