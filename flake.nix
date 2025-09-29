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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations = {
        skellybones = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./config/hosts/skellybones/os.nix
            nixos-hardware.nixosModules.framework-16-7040-amd
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./config/hosts/skellybones/home.nix;
            }
          ];
        };

        sylvia = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./config/hosts/sylvia/os.nix
            nixos-hardware.nixosModules.intel-nuc-8i7beh
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./config/hosts/sylvia/home.nix;
            }
          ];
        };

        stella = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./config/hosts/stella/os.nix
            nixos-hardware.nixosModules.intel-nuc-8i7beh
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./config/hosts/stella/home.nix;
            }
          ];
        };

        testvm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./config/hosts/testvm/os.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./config/hosts/skellybones/home.nix;
            }
          ];
        };
      };

      homeConfigurations = {
        "basic" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };

          modules = [
            ./config/hosts/standalone/basic.nix
          ];
        };

        "full" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };

          modules = [
            ./config/hosts/standalone/full.nix
          ];
        };
      };
    };
}
