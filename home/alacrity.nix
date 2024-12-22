{ config, pkgs, ... }:

# home-manager.users.alice =
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          dimensions = { columns = 150; lines = 45; };
          padding = { x = 15; y = 15; };
          decorations = "Full";
          opacity = 0.8;
          blur = false;
          startup_mode = "Windowed";
          title = "Alacritty";
          dynamic_title = true;
          resize_increments = true;
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        font = {
          # normal = { family = "CaskaydiaCove Nerd Font"; }; # FIXME: caskaydia is only in unstable
          size = 10;
          builtin_box_drawing = false;
        };

        colors = {
          search = {
            matches = { foreground = "#181818"; background = "#ac4242"; };
            focused_match = { foreground = "#181818"; background = "#f4bf75"; };
          };
          hints = {
            start = { foreground = "#181818"; background = "#f4bf75"; };
            end = { foreground = "#181818"; background = "#ac4242"; };
          };
          dim = {
            black = "#0f0f0f";
            red = "#712b2b";
            green = "#5f6f3a";
            yellow = "#a17e4d";
            blue = "#456877";
            magenta = "#704d68";
            cyan = "#4d7770";
            white = "#8e8e8e";
          };
          primary = {
            background = "#000000";
            foreground = "#CECECE";
          };
          cursor = {
            text = "#000000";
            cursor = "#CECECE";
          };
          normal = {
            black = "#000000";
            red = "#e25d56";
            green = "#73ca50";
            yellow = "#e9bf57";
            blue = "#4a88e4";
            magenta = "#915caf";
            cyan = "#23acdd";
            white = "#f0f0f0";
          };
          bright = {
            black = "#777777";
            red = "#f36868";
            green = "#88db3f";
            yellow = "#f0bf7a";
            blue = "#6f8fdb";
            magenta = "#e987e9";
            cyan = "#4ac9e2";
            white = "#FFFFFF";
          };
        };

        bell = {
          animation = "Linear";
          duration = 0;
          color = "#aaaaaa";
        };

        selection = {
          semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
          save_to_clipboard = false;

        };

        cursor = {
          style = { shape = "Block"; blinking = "Off"; };
          unfocused_hollow = true;
          thickness = 0.15;
        };

        mouse = {
          hide_when_typing = false;
        };

        keyboard = {
          bindings = [
            {key = "Backspace"; mods = "Control"; chars = "\u001b\u007f"; }
            {key = "Delete"; mods = "Control"; chars = "\ue000"; } # Unicode EXXX is reserved and unused so I pass this to zsh for delete word right
          ];
        };
      };
    };
  };
}
