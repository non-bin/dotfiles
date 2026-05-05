{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    systemd.enable = true;

    settings = {
      font-family = "CaskaydiaCove Nerd Font";
      font-size = 10;
      theme = "custom";
      cursor-style = "block";
      cursor-click-to-move = true;
      background-opacity = 0.8;
      background-blur = 20;
      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;
      focus-follows-mouse = true;
      clipboard-trim-trailing-spaces = true;
      copy-on-select = false;
      undo-timeout = "1m";
      confirm-close-surface = false;
    };

    themes.custom = {
      # Based on Everblush
      background = "#000000";
      foreground = "#cecece";
      cursor-color = "#cecece";
      cursor-text = "#000000";
      selection-background = "#141b1e";
      selection-foreground = "#dadada";
      palette = [
        "0=#000000"
        "1=#e25d56"
        "2=#73ca50"
        "3=#e9bf57"
        "4=#4a88e4"
        "5=#915caf"
        "6=#23acdd"
        "7=#f0f0f0"
        "8=#777777"
        "9=#f36868"
        "10=#88db3f"
        "11=#f0bf7a"
        "12=#6f8fdb"
        "13=#e987e9"
        "14=#4ac9e2"
        "15=#FFFFFF"
      ];
    };
  };
}
