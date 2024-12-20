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
    systemd-boot = {
      enable = true;
      configurationLimit = 50;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
  ];

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
