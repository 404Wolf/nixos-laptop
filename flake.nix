{
  description = "Collection of Wolf's NixOS and Home Manager Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dev.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firenvim.url = "github:404Wolf/firenvim-config";
    nix-neovim.url = "github:404Wolf/nix-neovim";
    capture-utils.url = "github:404Wolf/Screen-Capture";
    dalleCLI.url = "github:404Wolf/DALLE-CLI";
    remarkable-connection-utility.url = "github:/404wolf/remarkable-connection-utility";
    remarkable-obsidian.url = "github:404Wolf/remarkable-obsidian";
    cartographcf.url = "github:404Wolf/CartographCF";
    dashToDock.url = "github:404wolf/HyprDash";
    valfs.url = "github:404wolf/valfs";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-workspace2d = {
      url = "github:404wolf/Hyprland-Workspace-2D";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
    home-manager,
    nixos-hardware,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-options = {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = ["electron-25.9.0" "electron-32.3.3"];
      };
      permittedInsecurePackages = ["electron-25.9.0" "electron-32.3.3"];
    };

    pkgs-unstable = import nixpkgs-unstable pkgs-options;
    pkgs = import nixpkgs (pkgs-options
      // {
        overlays = [
          (final: prev: {
            firefox-devedition = pkgs-unstable.firefox-devedition;
            beeper = pkgs-unstable.beeper;

            wrappedNvim = inputs.nix-neovim.packages.${system}.default;
            capture-utils = inputs.capture-utils.packages.${system}.default;
            dalleCLI = inputs.dalleCLI.packages.${system}.default;
            nixGpt = inputs.nixGpt.packages.${system}.default;
            rcu = inputs.remarkable-connection-utility.packages.${system}.default;
            obsidian = inputs.remarkable-obsidian.packages.${system}.obsidian;
            cartographcf = inputs.cartographcf.packages.${system}.default;
            dashToDock = inputs.dashToDock.packages.${system}.default;
            valfs = inputs.valfs.packages.${system}.default;
            firefox-addons = inputs.firefox-addons.packages.${system};

            hyprland-workspace2d = inputs.hyprland-workspace2d.packages.${system}.workspace2d;
          })
          inputs.nur.overlays.default
        ];
      });

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
          inherit inputs pkgs-unstable system;
          helpers = utils;
          nix-colors = inputs.nix-colors;
        };
        modules =
          baseModules
          ++ [
            inputs.disko.nixosModules.disko
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./disko.nix
            {
              _module.args.disks = ["/dev/nvme0n1"];
              nixpkgs.system = system;
              home-manager.extraSpecialArgs = {inherit pkgs system;} // specialArgs;
              home-manager.backupFileExtension = ".bak";
            }
          ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          pkgs.wrappedNvim
          nil
          git
          nix
          sops
          gitleaks
          alejandra
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

      apps = {
        rebuild = flake-utils.lib.mkApp {
          drv = pkgs.writeShellApplication {
            name = "rebuild";
            text = builtins.readFile ./rebuild.sh;
            runtimeInputs = with pkgs; [git nix];
          };
        };
        vm = flake-utils.lib.mkApp {
          drv = pkgs.writeShellScriptBin "vm" ''
            ${self.nixosConfigurations.default.config.system.build.vm}/bin/run-*
          '';
        };
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
