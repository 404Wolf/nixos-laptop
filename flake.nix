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
    nix-colors.url = "github:misterio77/nix-colors";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    wolf-overlay.url = "github:404wolf/wolf-nixos-overlay";
  };
  dashToDock.url = "github:404wolf/HyprDash";

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
        inputs.wolf-overlay.overlays.${system}.default
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
