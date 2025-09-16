{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/os/docker.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest; # Sets the kernel version https://nixos.wiki/wiki/Linux_kernel

  services = {
    btrfs.autoScrub.enable = true;
    gvfs.enable = true; # Lets Thunar mount things
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        5000 # nix run github:edolstra/nix-serve
      ];
      allowedUDPPortRanges = [
        # { from = 4000; to = 4007; }
        # { from = 8000; to = 8010; }
      ];
    };
  };


  boot = {
    kernel.sysctl."kernel.sysrq" = 1; # TODO
    loader = {
      grub = {
        enable = true;
        configurationLimit = 50;
        efiSupport = lib.mkDefault true;
        device = lib.mkDefault "nodev";
      };

      efi.canTouchEfiVariables = lib.mkDefault true;
      timeout = 1;
      # timestampFormat = "%F %H:%M hi"; # TODO https://github.com/NixOS/nixpkgs/pull/366958
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    trusted-users = [ "@wheel"];
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; # Combine duplicates

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
      extraGroups = [ "wheel" "networkmanager" "adbusers" "libvirtd" "docker" "kvm" "tty" "dialout" ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlNlKIUyEMf23RugEgJXDMvNY2zDlM3IhONc3/NP4JD9ppoEcUE+JOAl6eVrMox/Q36ZcTHML8BxZfhQoXIGKZWq7ZwFX8pn5SFdNg5OZnY8e/NEEFA/EVOUvP/3L2+Rdkclwz5Rp1UL7Sv5gq98ZzuhxgDZDulDYknd5OGaBHWjrMo1b4Z9li/6aTCs53zl4/38o/TxDGHBiuNDWHtKkdJT47LQ3NVwkh8IP1Id8ZOhoZ0CHimTt0cUg45KLurH2tAU4PxPsaeaSwa6jMjBAY26I/6tadG4ztWlGGqsCYhwCsqCcOH0CRbfKi+qgqHuwa4Sw62fMdhqXl09zPf/VdY3HKdWL0gfyxV3uMTf2OEue6//SiWOJZRQZ9qVpLm5c13+y0A/RXpC3hS8gPvunVkGnj82lxPFrCLx9jYkhvRPLh+eUxwHjUIswFRGgX5vuxEt+0RTGs5jH2CIl5IdviBVWz5GsxcvyqRAuDKu9EkNNawfx1wr//09eBhNMvBw8="
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.pathsToLink = [ "/share/zsh" ]; # System package zsh completions

  programs = {
    zsh.enable = true;
    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };

  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };
}
