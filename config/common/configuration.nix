{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/docker.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest; # Sets the kernel version https://nixos.wiki/wiki/Linux_kernel

  services = {
    btrfs.autoScrub.enable = true;
    gvfs.enable = true; # Lets Thunar mount things
  };

  networking.networkmanager.enable = true;

  boot = {
    kernel.sysctl."kernel.sysrq" = 1; # TODO
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        configurationLimit = 50;
        device = "nodev";
      };

      efi.canTouchEfiVariables = true;
      timeout = 1;
      # timestampFormat = "%F %H:%M hi"; # TODO https://github.com/NixOS/nixpkgs/pull/366958
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    # List of binary cache URLs used to obtain pre-built binaries of Nix packages
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; # Combine duplicates
  };

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  # console = { # TODO
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  users = {
    groups.alice.gid = 1000;
    users.alice = {
      uid = 1000;
      description = "Alice Jacka";
      createHome = true;
      home = "/home/alice";
      group = "alice";
      extraGroups = [ "wheel" "networkmanager" "adbusers" "libvirtd" "docker" "kvm"];
      isNormalUser = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.pathsToLink = [ "/share/zsh" ]; # System package zsh completions

  programs = {
    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };

  services = {
    openssh.enable = true;
  };
}
