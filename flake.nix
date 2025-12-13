{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:non-bin/nixpkgs/live";
    # nixpkgs.url = "/home/alice/repos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland/main";
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
    let
      host =
        hostname: extraModules:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./config/hosts/${hostname}/os.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./config/hosts/${hostname}/home.nix;
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        maureen = host "maureen" [ ];
        skellybones = host "skellybones" [ nixos-hardware.nixosModules.framework-16-7040-amd ];
        stella = host "stella" [ ];
        sylvia = host "sylvia" [ nixos-hardware.nixosModules.intel-nuc-8i7beh ];
        testvm = host "testvm" [ ];
      };

      homeConfigurations = {
        "basic" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };

          modules = [ ./config/hosts/standalone/basic.nix ];
        };

        "full" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };

          modules = [ ./config/hosts/standalone/full.nix ];
        };
      };
    };
}
