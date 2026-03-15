{ pkgs, ... }:
let
  claude-monitor = pkgs.python3Packages.buildPythonPackage {
    pname = "claude-monitor";
    version = "3.1.0";
    pyproject = true;

    src = pkgs.fetchPypi {
      pname = "claude_monitor";
      version = "3.1.0";
      hash = "sha256-k5Hg78AeuWQ+RiI+b0mLjQPnxqTzfrugnJ81WgRT5/w=";
    };

    build-system = with pkgs.python3Packages; [ setuptools wheel ];

    dependencies = with pkgs.python3Packages; [
      numpy
      pydantic
      pydantic-settings
      pyyaml
      pytz
      rich
      tomli
    ];

    doCheck = false;
  };

  claude-output-monitor = pkgs.writeShellScriptBin "claude-output-monitor" ''
    exec ${claude-monitor}/bin/claude-monitor --plan max20 "$@"
  '';
in
{
  home.packages = [ claude-output-monitor ];

  programs.claude-code = {
    enable = true;

    mcpServers = {
      nixos = {
        command = "nix";
        args = [ "run" "github:utensils/mcp-nixos" "--" ];
      };
      "cratesio-mcp" = {
        type = "http";
        url = "https://cratesio-mcp.fly.dev/";
      };
      "github-copilot" = {
        type = "http";
        url = "https://api.githubcopilot.com/mcp/";
        headers = {
          "X-MCP-Toolsets" = "default,projects";
        };
      };
    };

    settings = {
      model = "sonnet";

      inputs = [
        {
          type = "promptString";
          id = "github_mcp_pat";
          description = "GitHub Personal Access Token";
          password = true;
        }
      ];
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
