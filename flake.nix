{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "github:non-bin/nixpkgs/bootLoaderGenerationFormat";
    # nixpkgs.url = "/home/alice/dotfiles/repos/nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations = {
      vickie = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/vickie/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alice = import ./hosts/vickie/home.nix;
          }
        ];
      };
      skellybones = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/skellybones/configuration.nix
          nixos-hardware.nixosModules.framework-16-7040-amd
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alice = import ./hosts/skellybones/home.nix;
          }
        ];
      };
    };
  };
}
