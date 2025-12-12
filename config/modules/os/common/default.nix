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

    ./btrbk.nix
    ./docker.nix
  ];

  services.btrfs.autoScrub.enable = lib.mkDefault true;

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        5000 # nix run github:edolstra/nix-serve

        # FIXME:
        25565 # minecraft
        80 # Testing things
        8080 # Testing things
      ];
    };
  };

  boot = {
    kernel.sysctl."kernel.sysrq" = 1; # FIXME
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
