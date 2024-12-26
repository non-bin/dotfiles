# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
  ];

  networking.hostName = "skellybones"; # Define your hostname.

  services = {
    btrfs.autoScrub.enable = true;
    fwupd.enable = true; # run with fwupdmgr update https://github.com/NixOS/nixos-hardware/tree/master/framework

    evremap = {
      enable = true;
      settings.device_name = "Framework Laptop 16 Keyboard Module - ANSI Keyboard"; # evremap list-devices
    };

    # btrbk = {
    #   instances."btrbk" = {
    #     onCalendar = "*:0/10"; # every 10 minuites
    #     settings = {
    #       snapshot_preserve_min = "2d"; # Keep everything for at least 2d
    #       snapshot_preserve = "20d 10w 12m"; # Keep daily backups for 20 days, weeklys for 10 weeks, and monthlies for 12 months
    #       volume."/mnt/btr_pool" = { # /dev/vg0/btr_pool
    #         subvolume = "home";
    #         snapshot_dir = "/mnt/btr_pool/btrbk_snapshots";
    #       };
    #     };
    #   };
    # };
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

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
