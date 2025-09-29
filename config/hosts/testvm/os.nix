{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/os/common/base.nix
  ];

  networking.hostName = "testvm";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.99";
      prefixLength = 24;
    }
  ];

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 8;
      graphics = false;
    };
  };

  services.getty.autologinUser = "alice";

  programs.dconf.enable = true; # "https://github.com/nix-community/home-manager/blob/master/docs/manual/faq/ca-desrt-dconf.md"
  services.btrfs.autoScrub.enable = lib.mkForce false;

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
