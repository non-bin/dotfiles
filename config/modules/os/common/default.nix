{
  config,
  lib,
  pkgs,
  inputs,
  user,
  ...
}:

{
  imports = [
    ./base.nix

    ./btrbk.nix
    ./docker.nix
    ./agenix.nix
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
    kernel = {
      sysctl."kernel.sysrq" = 1; # FIXME

      # Compressed RAM cache for swap pages
      sysfs.module.zswap.parameters = {
        enabled = true;
        compressor = "zstd";
        max_pool_percent = 20; # maximum percentage of RAM that zswap is allowed to use
        shrinker_enabled = true; # whether to shrink the pool proactively on high memory pressure
        accept_threshold_percent = 90; # hysteresis to refuse taking pages into zswap pool until it has sufficient space if the limit has been hit
      };
    };

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

  age.secrets.userPass.rekeyFile = ./userPass.age;
  users = {
    mutableUsers = false;

    users.${user.name} = {
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.userPass.path;
    };
  };

  environment.pathsToLink = [ "/share/zsh" ]; # System package zsh completions

  programs = {
    zsh.enable = true;
    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };

  services.udev.extraRules =
    let
      mkRule = as: lib.concatStringsSep ", " as;
      mkRules = rs: lib.concatStringsSep "\n" rs;
    in
    mkRules [
      (mkRule [
        ''ACTION=="add|change"''
        ''SUBSYSTEM=="block"''
        ''KERNEL=="sd[a-z]"''
        ''ATTR{queue/rotational}=="1"''
        #                        Aggressiveness    Standby time (*5seconds = 10minutes)
        ''RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 120 /dev/%k"''
      ])
    ];

}
