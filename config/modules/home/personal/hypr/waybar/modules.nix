{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.waybar = {
    settings.main-bar = {
      "hyprland/workspaces" = {
        on-click = "activate";
        active-only = false;
        all-outputs = true;
        show-special = true;
        format = "{id}";
        format-window-separator = "";
        ignore-workspaces = [ "special:special" ];
        window-rewrite-default = "";
        window-rewrite = {
          "title<.*youtube.*>" = "";
          "class<firefox>" = "";
          "class<firefox> title<.*github.*>" = "";
          "class<Alacritty>" = "";
          "class<codium>" = "󰨞";
          "class<GitKraken>" = "";
        };
      };
      "hyprland/window" = {
        icon = true;
        icon-size = 18;
        format = "{title}";
        separate-outputs = true;
      };
      "custom/appmenu" = {
        format = "Apps";
        tooltip-format = "Left: Open the application launcher\nRight: Show all keybindings";
        on-click = "rofi -show drun -replace";
        on-click-right = "~/.config/ml4w/scripts/keybindings.sh";
        tooltip = false;
      };
      "custom/exit" = {
        format = "";
        tooltip-format = "Powermenu";
        on-click = "wlogout";
        tooltip = false;
      };
      keyboard-state = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };
      tray = {
        spacing = 10;
      };
      clock = {
        tooltip-format = "<big>{:%a %e %b %Y}</big>\n<tt><small>{calendar}</small></tt>";
        interval = 1;
        format = "{:%I:%M %Y-%m-%d}";
        format-alt = "{:%I:%M:%S}";
      };
      "custom/system" = {
        format = "";
        tooltip = false;
      };
      cpu = {
        interval = 1;
        format = "C {usage}% ";
        on-click = "ghostty -e btop";
      };
      memory = {
        interval = 5;
        format = "M {}% ";
        on-click = "ghostty -e btop";
      };
      disk = {
        interval = 30;
        format = "D {percentage_used}% ";
        path = "/";
        on-click = "ghostty -e btop";
      };
      "hyprland/language" = {
        format = "/ K {short}";
      };
      network = {
        format = "{ifname}";
        format-wifi = "   {signalStrength}%";
        format-ethernet = "  {ipaddr}";
        format-disconnected = "Not connected";
        tooltip-format = " {ifname} via {gwaddri}";
        tooltip-format-wifi = "   {essid} ({signalStrength}%)";
        tooltip-format-ethernet = "  {ifname} ({ipaddr}/{cidr})";
        tooltip-format-disconnected = "Disconnected";
        max-length = 50;
        on-click = "ghostty -e nmtui";
      };
      battery = {
        interval = 3;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}   {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{icon} {time}";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
      };
      pulseaudio = {
        scroll-step = 5;
        reverse-scrolling = true;
        max-volume = 150;
        format = "{icon} {volume}%";
        format-muted = " "; # {format_source}
        format-bluetooth = "{icon} {volume}%"; # {format_source}
        format-bluetooth-muted = "{icon}  "; # {format_source}
        format-source = "{volume}% ";
        format-source-muted = " ";
        format-icons = {
          headphone = " ";
          hands-free = " ";
          headset = " ";
          phone = " ";
          portable = " ";
          car = " ";
          default = [
            " "
            " "
            "  "
          ];
        };
        interval = 10;
        on-click = "pavucontrol";
      };
      bluetooth = {
        format = " {num_connections}";
        format-connected-battery = " {num_connections} ({device_battery_percentage})";
        format-disabled = " Disabled";
        format-off = " Off";
        interval = 10;
        format-no-controller = " Error";
        on-click = "blueman-manager";
        tooltip-format-enumerate-connected = "{device_alias}";
        tooltip-format = "Status: {status}\n\nDevices:\n{device_enumerate}\n\nClick: blueman-manager";
      };
      user = {
        format = "{user}";
        interval = 60;
        icon = false;
      };
      idle_inhibitor = {
        format = "{icon}";
        tooltip = true;
        format-icons = {
          activated = "";
          deactivated = "";
        };
        on-click-right = "hyprlock";
      };
      "custom/quicklink1" = {
        format = " ";
        on-click = "~/.config/ml4w/apps/ML4W_Hyprland_Settings-x86_64.AppImage";
        tooltip-format = "Open Hyprland Settings";
      };
      "custom/quicklink2" = {
        format = " ";
        on-click = "~/.config/ml4w/settings/browser.sh";
        tooltip-format = "Open the browser";
      };
      "custom/quicklink3" = {
        format = " ";
        on-click = "~/.config/ml4w/settings/filemanager.sh";
        tooltip-format = "Open the filemanager";
      };
      "custom/quicklinkempty" = { };
      "group/hardware" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 300;
          children-class = "not-memory";
          transition-left-to-right = false;
        };
        modules = [
          "custom/system"
          "disk"
          "cpu"
          "memory"
          "hyprland/language"
        ];
      };
      "group/quicklinks" = {
        orientation = "horizontal";
        modules = [
          "custom/quicklink1"
          "custom/quicklink2"
          "custom/quicklink3"
          "custom/quicklinkempty"
        ];
      };
    };
  };
}
