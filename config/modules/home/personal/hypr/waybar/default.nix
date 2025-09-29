{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./modules.nix
  ];

  programs.waybar = {
    enable = true;

    style = builtins.readFile ./style.css;

    settings.main-bar = {
      #output = "eDP-1";
      #height = 30; # Waybar height (to be removed for auto height)
      #spacing = 4; # Gaps between modules (4px)

      modules-left = [
        "user"
        # "custom/appmenu"
        # "group/quicklinks"
        "hyprland/window"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "tray"
        "mpd"
        "pulseaudio"
        "network"
        "bluetooth"
        "cpu"
        "memory"
        "keyboard-state"
        "battery"
        "clock"
      ];
    };
  };
}
