{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./base.nix

    ./secrets
    ./btrbk.nix
    ./docker.nix
  ];

  services.btrfs.autoScrub.enable = true;

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
      # timestampFormat = "%F %H:%M"; # TODO https://github.com/NixOS/nixpkgs/pull/366958
    };
  };

  # console = { # TODO
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  users.users.alice.shell = pkgs.zsh;

  environment.pathsToLink = [ "/share/zsh" ]; # System package zsh completions

  programs = {
    zsh.enable = true;
    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };
}
