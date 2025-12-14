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

    # Pick one
    # ../../modules/os/common/base.nix
    # ../../modules/os/common
    ../../modules/os/server.nix

    # ../../modules/os/server/servarr

    # ../../modules/os/common/secrets/default.nix # Only really needed if just using base.nix
  ];

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmf+ifxiYomJJfZzIcWpZUkqUC1usBUCD7BhCb8S8w0";

  networking.hostName = "testvm";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.99";
      prefixLength = 24;
    }
  ];

  # following configuration is added only when building VM with build-vm
  # virtualisation.vmVariant.virtualisation = {
  #   memorySize = 4096; # Use 2048MiB memory.
  #   cores = 8;
  #   graphics = false;
  #   # forwardPorts = [
  #   #   {
  #   #     from = "host";
  #   #     host.port = 8080;
  #   #     guest.port = 80;
  #   #   }
  #   # ];
  #   qemu.networkingOptions = [
  #     # "-net nic,netdev=user,model=virtio"
  #     # "-netdev user,id=usea,\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS}"
  #     # "-netdev bridge,id=hn0"
  #     # "-device virtio-net-pci,netdev=hn0,id=nic1"
  #     "-netdev tap,id=net0,br=br0,helper=$(type -p qemu-bridge-helper)"
  #   ];
  # };

  # services.getty.autologinUser = user.name;

  # environment.shellAliases = {
  #   s = "sudo shutdown now"; # Quick shutdown
  # };

  # Workarounds
  # programs.dconf.enable = true; # "https://github.com/nix-community/home-manager/blob/master/docs/manual/faq/ca-desrt-dconf.md"
  # services.btrfs.autoScrub.enable = lib.mkForce false;
  # virtualisation.docker.storageDriver = lib.mkForce null;

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
