{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/server.nix
  ];

  # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn8uDmv1Bo4GZw2hdwoKvCvWD1k7Rag8W89c85OjZpw";

  networking.hostName = "stella";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.84";
      prefixLength = 24;
    }
  ];

  # services.beszel.agent = {
  #   enable = true;
  #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqQ4E9KwbgyCb1pj912x2gzG1x+Eqir+/Yg5PRISjio";
  # };

  # boot.loader = {
  #   grub = {
  #     efiSupport = false;
  #     device = "/dev/disk/by-id/wwn-0x5000c50064f0f0c5";
  #   };

  #   efi.canTouchEfiVariables = false;
  # };

  # cloudflared tunnel create <tunnel-name>
  age.secrets.cloudflared.rekeyFile = ./cloudflared.age;
  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "b5fdc338-3d9f-42dc-9ba6-244a1ea89409" = {
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
    };
  };

  users.users.family.isNormalUser = true; # maybe need to add to samba group?
  age.secrets.familySambaPassword.rekeyFile = ./familySambaPassword.age;
  # The password is repeated twice with newline characters as smbpasswd requires a password
  # confirmation even in non-interactive mode where input is piped in through stdin.
  system.activationScripts.init_smbpasswd.text = ''${pkgs.coreutils}/bin/printf "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.familySambaPassword.path})\n$(${pkgs.coreutils}/bin/cat ${config.age.secrets.familySambaPassword.path})\n" | ${pkgs.samba}/bin/smbpasswd -sa family'';

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
  system.stateVersion = "26.05"; # Did you read the comment?
}
