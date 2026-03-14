{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;

    settings = {
      hooks = {
        Notification = [
          {
            hooks = [
              {
                type = "command";
                command = "${pkgs.sound-effects-cli}/bin/sound-effects upbeat-motivational.mp3";
              }
            ];
          }
        ];
        TaskCompleted = [
          {
            hooks = [
              {
                type = "command";
                command = "${pkgs.sound-effects-cli}/bin/sound-effects happy-kids.mp3";
              }
            ];
          }
        ];
      };

      enabledPlugins = {
        "rust-analyzer-lsp@claude-plugins-official" = true;
        "frontend-design@claude-plugins-official" = false;
        "github@claude-plugins-official" = true;
        "honeycomb@honeycomb-plugins" = true;
      };

      spinnerVerbs = {
        mode = "replace";
        verbs = [
          "Annihilating"
          "Atomizing"
          "Autoclaving"
          "Beaming"
          "Bombarding"
          "Bursting"
          "Cleaving"
          "Cratering"
          "Cryofreezing"
          "Decimating"
          "Destabilizing"
          "Detonating"
          "Devastating"
          "Disintegrating"
          "Dismantling"
          "Electronizing"
          "Eliminating"
          "Eradicating"
          "Exterminating"
          "Hyperjumping"
          "Igniting"
          "Impacting"
          "Incinerating"
          "Ionizing"
          "Irradiating"
          "Jamming"
          "Lancing"
          "Launching"
          "Leveling"
          "Melting"
          "Neutralizing"
          "Neutronizing"
          "Nuking"
          "Obliterating"
          "Overcharging"
          "Overheating"
          "Overloading"
          "Overpressurizing"
          "Overwhelming"
          "Overwriting"
          "Penetrating"
          "Perforating"
          "Phasoring"
          "Photonizing"
          "Piercing"
          "Plasmatizing"
          "Protonizing"
          "Pulverizing"
          "Purging"
          "Quantizing"
          "Railgunning"
          "Rupturing"
          "Scorching"
          "Scouring"
          "Shattering"
          "Splitting"
          "Strafing"
          "Superheating"
          "Suppressing"
          "Surging"
          "Sweeping"
          "Terminating"
          "Torpedoing"
          "Vaporizing"
          "Venting"
          "Warping"
        ];
      };
    };
  };
}
