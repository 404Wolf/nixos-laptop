{config, ...}: {
  services.cloudflared = {
    enable = true;

    systemd.services.my_tunnel = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      serviceConfig = {
        ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=<token>";
        Restart = "always";
        User = "cloudflared";
        Group = "cloudflared";
      };
    };
  };
}
