{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      # https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/

      general = {
        ignore_empty_input = true;
        hide_cursor = true;
        grace = 5;
      };

      background = {
        path = "${config.home.homeDirectory}/wallpapers/lockscreen/calder-moore-scifi-elevator-fin.jpg";
      };

      auth = {
        "fingerprint:enabled" = true;
      };

      input-field = {
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
        outer_color = "rgb(151515)";
        inner_color = "rgb(FFFFFF)";
        font_color = "rgb(10, 10, 10)";
        fade_on_empty = true;
        fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
        placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        rounding = -1; # -1 means complete rounding (circle/oval)
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        fail_transition = 300; # transition time in ms between normal outer_color and fail_color
        capslock_color = "rgb(255, 153, 0)";
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below
        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          # Fprint
          text = "$FPRINTPROMPT";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 15;
          font_family = "Fira Semibold";
          halign = "right";
          valign = "bottom";
          text_align = "right";
          position = "-5, 100";
          shadow_passes = 5;
          shadow_size = 10;
        }

        {
          # Time
          text = ''cmd[update:1000] date "+%l:%M %p"'';
          # text = "cmd[update:1000] date +%r";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 55;
          font_family = "Fira Semibold";
          halign = "right";
          valign = "bottom";
          text_align = "right";
          position = "-5, 23";
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          # Date and battery
          text = ''cmd[update:1000] echo "$(/home/alice/dotfiles/scripts/englishDate.sh) $(cat /sys/class/power_supply/BAT1/capacity && echo %)"|tr -d "\n"'';
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 20;
          font_family = "Fira Semibold";
          halign = "right";
          valign = "bottom";
          text_align = "right";
          position = "-5, 5";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}
