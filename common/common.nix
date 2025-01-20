# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  programs.nix-ld.enable = true; # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.libraries = with pkgs; [ # https://github.com/cloudflare/workerd/discussions/1515#discussioncomment-10029667
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

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    # systemd-boot = {
    #   enable = true;
    #   configurationLimit = 50;
    # };

    grub = {
      enable = true;
      efiSupport = true;
      configurationLimit = 50;
      device = "nodev";
    };

    efi.canTouchEfiVariables = true;
    timeout = 1;
    # timestampFormat = "%F %H:%M hi";
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; # Combine duplicates

    # List of binary cache URLs used to obtain pre-built binaries of Nix packages
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  # console = {
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
      extraGroups = [ "wheel" "networkmanager" "adbusers" ];
      isNormalUser = true;
      packages = with pkgs; [];
    };
  };

  security.sudo.wheelNeedsPassword = true;

  environment.pathsToLink = [ "/share/zsh" ]; # System package zsh completions

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  programs = {
    hyprland.enable = true; # Enable system wide, configure in HM
    adb.enable = true;

    regreet = {
      enable = true;
      font.package = pkgs.roboto;
      font.name = "Roboto";
      cursorTheme.package = pkgs.canta-theme;
      cursorTheme.name = "Canta";
      iconTheme.package = pkgs.canta-theme;
      iconTheme.name = "Canta";
      theme.package = pkgs.canta-theme;
      theme.name = "Canta";
      settings = {
        background = {
          path = "${../wallpapers/calder-moore-factorycomped.jpg}";
          fit = "Cover";
        };
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };

    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };

  services = {
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;

    logind = {
      # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"
      hibernateKey = "hibernate";
      hibernateKeyLongPress = "ignore";
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore"; # When a second screen is attached
      # lidSwitchExternalPower = ""; # Falls back to lidSwitch
      powerKey = "ignore";
      powerKeyLongPress = "ignore";
      rebootKey = "reboot";
      rebootKeyLongPress = "ignore";
      suspendKey = "suspend";
      suspendKeyLongPress = "ignore";

      extraConfig = ""; # https://www.freedesktop.org/software/systemd/man/logind.conf.html
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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
