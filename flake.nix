{
  description = "Collection of Wolf's NixOS and Home Manager Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dev.url = "github:nixos/nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-neovim.url = "github:404Wolf/nix-neovim";
    capture-utils.url = "github:404Wolf/Screen-Capture";
    dalleCLI.url = "github:404Wolf/DALLE-CLI";
    remarkable-connection-utility.url = "github:/404wolf/remarkable-connection-utility";
    cartographcf.url = "github:404Wolf/CartographCF";
    dashToDock.url = "github:404wolf/HyprDash";
    valfs.url = "github:404wolf/valfs";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zed.url = "github:zed-industries/zed";
    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
    };

    hyprland-workspace2d = {
      url = "github:404wolf/Hyprland-Workspace-2D";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Mac modules
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nixos-hardware,
    darwin,
    nix-homebrew,
    homebrew-cask,
    homebrew-core,
    homebrew-bundle,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-options = {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
          "electron-32.3.3"
        ];
      };
      permittedInsecurePackages = [
        "electron-25.9.0"
        "electron-32.3.3"
      ];
    };

    pkgs = import nixpkgs (
      pkgs-options
      // {
        overlays = [
          (final: prev: {
            wrappedNvim = inputs.nix-neovim.packages.${system}.default;
            capture-utils = inputs.capture-utils.packages.${system}.default;
            dalleCLI = inputs.dalleCLI.packages.${system}.default;
            nixGpt = inputs.nixGpt.packages.${system}.default;
            rcu = inputs.remarkable-connection-utility.packages.${system}.default;
            cartographcf = inputs.cartographcf.packages.${system}.default;
            dashToDock = inputs.dashToDock.packages.${system}.default;
            valfs = inputs.valfs.packages.${system}.default;
            firefox-addons = inputs.firefox-addons.packages.${system};
            zed-editor = inputs.zed.packages.${system}.default;

            hyprland-workspace2d = inputs.hyprland-workspace2d.packages.${system}.workspace2d;
          })
          inputs.nur.overlays.default
          inputs.nix-vscode-extensions.overlays.default
          inputs.zed-extensions.overlays.default
        ];
      }
    );

    utils = pkgs.callPackage ./utils.nix {};

    baseModules = [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          users.wolf = ./home/users/wolf;
          sharedModules = [
            inputs.zed-extensions.homeManagerModules.default
          ];
        };
      }
      inputs.sops-nix.nixosModules.sops
      ./nixos
      ./sops.nix
    ];
  in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem rec {
        inherit system pkgs;
        specialArgs = {
          inherit inputs system;
          helpers = utils;
          nix-colors = inputs.nix-colors;
        };
        modules =
          baseModules
          ++ [
            inputs.disko.nixosModules.disko
            ./disko.nix
            {
              _module.args.disks = ["/dev/nvme0n1"];
              nixpkgs.system = system;
              home-manager.extraSpecialArgs =
                {
                  inherit pkgs system;
                  machine = "framework";
                }
                // specialArgs;
              home-manager.backupFileExtension = ".bak";
            }
            nixos-hardware.nixosModules.framework-13-7040-amd
          ];
      };

      darwinConfigurations.default = darwin.lib.darwinSystem {
        inherit system pkgs;
        specialArgs = inputs;
        modules = [
          inputs.mac-app-util.darwinModules.default
          {
            home-manager = {
              users.wolf = ./users/wolf;
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [inputs.mac-app-util.homeManagerModules.default];
              extraSpecialArgs = {
                inherit inputs utils;
                helpers = utils;
                machine = "mac";
              };
            };
          }
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "wolf";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
              autoMigrate = true;
            };
          }
          ./darwin.nix
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
          nixfmt-classic
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
            runtimeInputs = with pkgs; [
              git
              nix
            ];
          };
        };
        vm = flake-utils.lib.mkApp {
          drv = pkgs.writeShellScriptBin "vm" ''
            ${self.nixosConfigurations.default.config.system.build.vm}/bin/run-*
          '';
        };
      };

      packages.default =
        (nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ];
        }).config.system.build.isoImage;
    });
}
