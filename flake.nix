{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:non-bin/nix-on-droid/testing";
      # url = "github:non-bin/nix-on-droid/unstable";
      # url = "github:nix-community/nix-on-droid/testing";
      # url = "github:nix-community/nix-on-droid/prerelease-25.11";
      # url = "github:nix-community/nix-on-droid/master";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "github:hyprwm/Hyprland/main";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    agenix.url = "github:ryantm/agenix";
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-on-droid,
      nixos-hardware,
      agenix,
      agenix-rekey,
      ...
    }:
    let
      user = {
        fullName = "Alice Jacka";
        name = "alice";
        email = "jacka.alice@gmail.com";
        sshKeys = {
          personal = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlNlKIUyEMf23RugEgJXDMvNY2zDlM3IhONc3/NP4JD9ppoEcUE+JOAl6eVrMox/Q36ZcTHML8BxZfhQoXIGKZWq7ZwFX8pn5SFdNg5OZnY8e/NEEFA/EVOUvP/3L2+Rdkclwz5Rp1UL7Sv5gq98ZzuhxgDZDulDYknd5OGaBHWjrMo1b4Z9li/6aTCs53zl4/38o/TxDGHBiuNDWHtKkdJT47LQ3NVwkh8IP1Id8ZOhoZ0CHimTt0cUg45KLurH2tAU4PxPsaeaSwa6jMjBAY26I/6tadG4ztWlGGqsCYhwCsqCcOH0CRbfKi+qgqHuwa4Sw62fMdhqXl09zPf/VdY3HKdWL0gfyxV3uMTf2OEue6//SiWOJZRQZ9qVpLm5c13+y0A/RXpC3hS8gPvunVkGnj82lxPFrCLx9jYkhvRPLh+eUxwHjUIswFRGgX5vuxEt+0RTGs5jH2CIl5IdviBVWz5GsxcvyqRAuDKu9EkNNawfx1wr//09eBhNMvBw8=";

          # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
          maureen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDz2Ia+hmbEQ0kuXxIEbFv6zxM+zXVXePq+jZxLrZiE1";
          skellybones = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFr10kZ2FZeqfcMnYXIqCW1V5HMPIwb0f4OfJa5mGov2";
          stella = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn8uDmv1Bo4GZw2hdwoKvCvWD1k7Rag8W89c85OjZpw";
          pandora = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMDRtk3JliTktdSozZu9Om+vmRlpAHU9uE1AidyQEPHi";
        };

        system.stateVersion = "24.11"; # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration, and migrated your data accordingly. https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
      };
    in
    {
      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nixosConfigurations = self.nixosConfigurations;
      };

      nixosConfigurations =
        (
          config:
          nixpkgs.lib.genAttrs (builtins.attrNames config) (
            hostname:
            let
              hostConfig = nixpkgs.lib.recursiveUpdate {
                extraModules = [ ];
                system = "x86_64-linux";
                inherit user;
              } config.${hostname};

              specialArgs = {
                inherit inputs;
                user = hostConfig.user;
              };
            in
            nixpkgs.lib.nixosSystem {
              inherit specialArgs;
              system = hostConfig.system;
              modules = [
                ./config/hosts/${hostname}/os.nix
                agenix.nixosModules.default
                agenix-rekey.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                  home-manager.extraSpecialArgs = specialArgs;
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.${hostConfig.user.name} = import ./config/hosts/${hostname}/home.nix;
                }
              ]
              ++ hostConfig.extraModules;
            }
          )
        )
          {
            maureen = { };
            skellybones = {
              extraModules = [ nixos-hardware.nixosModules.framework-16-7040-amd ];
            };
            stella = { };
            sylvia = {
              extraModules = [ nixos-hardware.nixosModules.intel-nuc-8i7beh ];
            };
            pandora = {
              user = {
                fullName = "Kieran Jacka";
                name = "kieran";
              };
            };
            testvm = { };
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

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = { inherit user; };
        pkgs = import nixpkgs {
          # stdenv.hostPlatform.system = "aarch64-linux";
          # currentSystem = "aarch64-linux";
        };
        modules = [ ./config/hosts/nix-on-droid/os.nix ];
      };

      inherit inputs; # Useful for nix repl
    };
}
