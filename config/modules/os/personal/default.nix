{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./regreet.nix
    ./btrbk.nix
  ];

  programs.nix-ld.enable = true; # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.libraries = with pkgs; [
    # https://github.com/cloudflare/workerd/discussions/1515#discussioncomment-10029667
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel"))
          return polkit.Result.YES;
      });
    '';
  };

  boot.loader.grub.useOSProber = false;

  nixpkgs.config.android_sdk.accept_license = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs = {
    hyprland = {
      enable = true; # Enable system wide, configure in HM
      # Use the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # Make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    gamemode.enable = true;

    virt-manager.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    tumbler.enable = true; # Image thumbnails
    gvfs.enable = true; # Lets Thunar mount things

    locate = {
      enable = true;
      prunePaths = [
        "/snapshots"
        "/tmp"
        "/var/tmp"
        "/var/cache"
        "/var/lock"
        "/var/run"
        "/var/spool"
        "/nix/store"
        "/nix/var/log/nix"
      ];
    };

    cloudflare-warp = {
      enable = false;
    };

    logind = {
      settings.Login = {
        # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"
        HandleHibernateKey = "hibernate";
        HandleHibernateKeyLongPress = "ignore";
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore"; # When a second screen is attached
        # HandleLidSwitchExternalPower = ""; # Falls back to lidSwitch
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "ignore";
        HandleRebootKey = "reboot";
        HandleRebootKeyLongPress = "ignore";
        HandleSuspendKey = "suspend";
        HandleSuspendKeyLongPress = "ignore";
      };
    };

    evremap = {
      # Must enable and set device name in host config
      # enable = true;
      # settings.device_name = "Framework Laptop 16 Keyboard Module - ANSI Keyboard"; # evremap list-devices
      settings = {
        remap = [
          {
            input = [ "KEY_ESC" ];
            output = [ "KEY_CAPSLOCK" ];
          }
          {
            input = [ "KEY_CAPSLOCK" ];
            output = [ "KEY_ESC" ];
          }
        ];
      };
    };

    transmission = {
      package = pkgs.transmission_4;
      enable = true;
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ]; # For shared folders
    };

    spiceUSBRedirection.enable = true;
  };
}
