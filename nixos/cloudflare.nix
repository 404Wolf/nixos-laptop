{
  pkgs,
  config,
  ...
}: {
  services.cloudflared = {
    enable = true;
  };
  systemd.services._404wolf_tunnel = let
    _404wolfToken = config.sops.secrets."remotes/cloudflare/404wolf".path;
  in {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      ExecStart = "${pkgs.writeShellApplication {
        name = "cloudflared-tunnel";
        text = ''
          cloudflared tunnel --no-autoupdate run --token="$(cat ${_404wolfToken})" 404wolf-tunnels
        '';
        runtimeInputs = [pkgs.cloudflared];
      }}/bin/cloudflared-tunnel";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}
