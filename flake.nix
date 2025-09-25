{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:non-bin/nixpkgs/live";
    # nixpkgs.url = "/home/alice/repos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = ""; # Don't download mac deps
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, agenix, ... }: {
    nixosConfigurations = {
      skellybones = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./config/personal/hosts/skellybones/os.nix
          agenix.nixosModules.default
          nixos-hardware.nixosModules.framework-16-7040-amd
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alice = import ./config/personal/hosts/skellybones/home.nix;
          }
        ];
      };

      sylvia = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./config/servers/hosts/sylvia/os.nix
          agenix.nixosModules.default
          nixos-hardware.nixosModules.intel-nuc-8i7beh
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alice = import ./config/servers/hosts/sylvia/home.nix;
          }
        ];
      };

      stella = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./config/servers/hosts/stella/os.nix
          agenix.nixosModules.default
          nixos-hardware.nixosModules.intel-nuc-8i7beh
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alice = import ./config/servers/hosts/stella/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      "basic" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          ./config/personal/hosts/standalone/basic.nix
        ];
      };

      "full" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          ./config/personal/hosts/standalone/full.nix
        ];
      };
    };
  };
}
