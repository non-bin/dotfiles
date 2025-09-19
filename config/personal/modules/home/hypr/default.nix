{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./waybar
    ./land.nix
    ./idle.nix
    ./lock.nix
  ];

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
