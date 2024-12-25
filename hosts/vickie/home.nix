{ config, pkgs, lib, ... }:

# home-manager.users.alice =
{
  imports = [
    ../../home/home.nix
  ];

  wayland.windowManager = {
    hyprland = {
      settings = {
        # "$mod" = lib.mkForce "ALT";
        monitor = lib.mkForce ",highres,auto,auto";
      };
    };
  };
}
