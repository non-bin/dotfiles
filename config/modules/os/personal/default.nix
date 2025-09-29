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

  services.gvfs.enable = true; # Lets Thunar mount things

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

  nix.settings = {
    # List of binary cache URLs used to obtain pre-built binaries of Nix packages
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs = {
    hyprland.enable = true; # Enable system wide, configure in HM
    gamemode.enable = true;
    adb.enable = true;

    virt-manager.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
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
            input = [
              "KEY_ESC"
            ];
            output = [
              "KEY_CAPSLOCK"
            ];
          }
          {
            input = [
              "KEY_CAPSLOCK"
            ];
            output = [
              "KEY_ESC"
            ];
          }
        ];
      };
    };

    transmission = {
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
