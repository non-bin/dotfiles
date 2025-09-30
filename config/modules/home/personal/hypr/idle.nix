{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  services.hypridle = {
    enable = true;
    settings = {
      # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "pidof hyprlock || hyprlock --immediate --no-fade-in & loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = (builtins.floor 3 * 60); # 2.5min.
          on-timeout = "brightnessctl -s set 0"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }

        {
          timeout = (builtins.floor 5.5 * 60); # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = (builtins.floor 6 * 60); # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        {
          timeout = (builtins.floor 30 * 60); # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
