{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./waybar
    ./land.nix
    ./idle.nix
    ./lock.nix
    ./wlogout.nix
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = true;
      splash_offset = 2.0;
    };
  };

  home.pointerCursor = {
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 18;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };
  };
}
