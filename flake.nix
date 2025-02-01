{
  description = "Collection of Wolf's NixOS and Home Manager Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-utils.url = "github:numtide/flake-utils";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hyprland-plugins.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-workspace2d.url = "github:404wolf/Hyprland-Workspace-2D";
    hyprland-workspace2d.inputs.nixpkgs.follows = "nixpkgs";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpaper.inputs.nixpkgs.follows = "nixpkgs";
    nixGpt.url = "github:404Wolf/nixified-gpt-cli";
    dalleCLI.url = "github:404Wolf/DALLE-CLI";
    dashToDock.url = "github:404wolf/HyprDash";
    capture-utils.url = "github:404Wolf/Screen-Capture";
    nix-neovim.url = "github:404Wolf/nix-neovim";
    nix-colors.url = "github:misterio77/nix-colors";
    remarkable-connection-utility.url = "github:/404wolf/remarkable-connection-utility";
    remarkable-obsidian.url = "github:404Wolf/remarkable-obsidian";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nixos-hardware,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      permittedInsecurePackages = ["electron-25.9.0"];
      overlays = [
        (final: prev: {
          hyprpaper = inputs.hyprpaper.packages.${system}.default;
          hyprland-workspace2d = inputs.hyprland-workspace2d.packages.${system}.workspace2d;
          wrappedNvim = inputs.nix-neovim.packages.${system}.default;
          capture-utils = inputs.capture-utils.packages.${system}.default;
          dalleCLI = inputs.dalleCLI.packages.${system}.default;
          nixGpt = inputs.nixGpt.packages.${system}.default;
          rcu = inputs.remarkable-connection-utility.packages.${system}.default;
          obsidian = inputs.remarkable-obsidian.packages.${system}.obsidian;
        })
        inputs.nur.overlays.default
      ];
    };

    utils = pkgs.callPackage ./utils.nix {};

    baseModules = [
      home-manager.nixosModules.home-manager
      {home-manager.users.wolf = ./home/users/wolf;}
      inputs.sops-nix.nixosModules.sops
      ./nixos
      ./sops.nix
    ];
  in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem rec {
        inherit system pkgs;
        specialArgs = {
          inherit inputs;
          helpers = utils;
          nix-colors = inputs.nix-colors;
        };
        modules =
          baseModules
          ++ [
            inputs.disko.nixosModules.disko
            nixos-hardware.nixosModules.lenovo-legion-16irx8h
            ./disko.nix
            {
              _module.args.disks = ["/dev/nvme0n1"];
              nixpkgs.system = system;
              home-manager.extraSpecialArgs = {inherit pkgs system;} // specialArgs;
            }
          ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          inputs.nix-neovim.packages.${system}.default
          git
          nix
          sops
          gitleaks
        ];
      };

      formatter = let
        treefmtconfig = inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.shellcheck.enable = true;
          settings.formatter.shellcheck.excludes = [".envrc"];
        };
      in
        treefmtconfig.config.build.wrapper;

      apps.vm = flake-utils.lib.mkApp {
        drv = pkgs.writeShellScriptBin "vm" ''
          ${self.nixosConfigurations.default.config.system.build.vm}/bin/run-*
        '';
      };

      packages.default =
        (nixpkgs.lib.nixosSystem
          {
            inherit system pkgs;
            modules = [(nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")];
          })
        .config
        .system
        .build
        .isoImage;
    });
}
