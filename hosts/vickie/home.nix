{ config, pkgs, lib, hyprland-source, ... }:

# home-manager.users.alice =
{
  imports = [
    ../../home/home.nix
  ];

  wayland.windowManager.hyprland = {
    package = hyprland-source.hyprland;
    settings = {
      # "$mod" = lib.mkForce "ALT";
      monitor = lib.mkForce ",highres,auto,auto";
    };
  };

  programs.alacritty.settings.window.opacity = 1;
}
