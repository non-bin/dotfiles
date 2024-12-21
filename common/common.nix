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
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      packages = with pkgs; [];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [];

  programs = {
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
    hyprland.enable = true;
  };

  # Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
