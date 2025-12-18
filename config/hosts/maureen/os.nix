{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/server.nix

    ../../modules/os/server/homepage.nix
    ../../modules/os/server/immich.nix
    ../../modules/os/server/jellyfin.nix
    ../../modules/os/server/servarr/sonarr.nix
    ../../modules/os/server/servarr/radarr.nix
  ];

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDz2Ia+hmbEQ0kuXxIEbFv6zxM+zXVXePq+jZxLrZiE1";

  networking.hostName = "maureen";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.77";
      prefixLength = 24;
    }
  ];

  age.secrets.cloudflared.rekeyFile = ./cloudflared.age;
  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "da633e58-a1d2-49a3-bf12-ca6e5caf6621" = {
          credentialsFile = config.age.secrets.cloudflared.path;
          default = "http_status:404";
        };
      };
    };

    homepage-dashboard.widgets = [
      {
        resources = {
          label = "/boot";
          disk = [ "/boot" ];
        };
      }
      {
        resources = {
          label = "Fast";
          disk = [ "/" ];
        };
      }
      {
        resources = {
          label = "Slow";
          disk = [ "/mnt/backups" ];
        };
      }
    ];

    # beszel = {
    #   agent = {
    #     enable = true;
    #     key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqQ4E9KwbgyCb1pj912x2gzG1x+Eqir+/Yg5PRISjio";
    #   };
    #   hub = {
    #     enable = true;
    #     httpListen = "127.0.0.1:8080";
    #   };
    # };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
