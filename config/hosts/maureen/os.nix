{
  config,
  user,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/server.nix

    ../../modules/os/server/samba.nix
    ../../modules/os/server/homepage.nix
    ../../modules/os/server/immich.nix
    ../../modules/os/server/jellyfin.nix
    ../../modules/os/server/servarr/sonarr.nix
    ../../modules/os/server/servarr/radarr.nix
    ../../modules/os/server/servarr/lidarr.nix

    # ../../modules/os/server/minecraft.nix
  ];

  # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  age.rekey.hostPubkey = user.sshKeys.maureen;

  networking.hostName = "maureen";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.77";
      prefixLength = 24;
    }
  ];

  hardware.nvidia.open = true;
  services.xserver.videoDrivers = [ "nvidia" ]; # Even on wayland

  custom.btrbkSSHKeys = with user.sshKeys; [
    skellybones
    stella
  ];

  # cloudflared tunnel create <tunnel-name>
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

    samba.settings = {
      "root" = {
        "path" = "/";
        "browseable" = "yes";
        "valid users" = user.name;
        "force user" = user.name;
        "force group" = user.name;
        "guest ok" = "no";
        "read only" = "no";
      };
      "data" = {
        "path" = "/mnt/data";
        "browseable" = "yes";
        "valid users" = user.name;
        "force user" = user.name;
        "force group" = user.name;
        "guest ok" = "no";
        "read only" = "no";
      };
      "media" = {
        "path" = "/mnt/media";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "write list" = user.name;
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = user.name;
        "force group" = user.name;
      };
      "public" = {
        "path" = "/mnt/data/public";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = user.name;
        "force group" = user.name;
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
}
