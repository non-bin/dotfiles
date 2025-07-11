{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./binds.nix
    ./env.nix

    ./idle.nix
    ./lock.nix
  ];

  home.pointerCursor = {
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 18;
    # https://github.com/ful1e5/Bibata_Cursor?tab=readme-ov-file#notes
    # Bibata-Modern-Amber
    # Bibata-Modern-Classic
    # Bibata-Modern-Ice
    # Bibata-Modern-Amber-Right
    # Bibata-Modern-Classic-Right
    # Bibata-Modern-Ice-Right
    # Bibata-Original-Amber
    # Bibata-Original-Classic
    # Bibata-Original-Ice
    # Bibata-Original-Amber-Right
    # Bibata-Original-Classic-Right
    # Bibata-Original-Ice-Right
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };
  };

  wayland.windowManager = {
    hyprland = {
      enable = true;

      # Tell systemd to import the environment, otherwise it won't find some binaries
      systemd.variables = ["--all"];

      settings = {
        # See https://wiki.hyprland.org/Configuring/Monitors/
        # hyprctl monitors all
        monitor = ",2560x1600@165,auto,1.333333";

        # https://wiki.hyprland.org/Configuring/Animations/ for more
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # https://wiki.hyprland.org/Configuring/Variables/
        decoration = {
          rounding = 15;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          active_opacity = 1;
          inactive_opacity = 1;
          fullscreen_opacity = 1;
          dim_inactive = true;
          dim_strength = 0.1;
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = true;
          workspace_swipe_distance = 200;
          workspace_swipe_direction_lock = false;
        };

        general = {
          gaps_in = 2;
          gaps_out = 4;
          gaps_workspaces = 10;
          border_size = 0;
          "col.active_border" = "rgb(FFA348)";
          "col.inactive_border" = "rgb(595959)";
          no_border_on_floating = true;
          layout = "dwindle";
          resize_on_border = true;
          no_focus_fallback = true;
        };

        input = {
          kb_layout = "us";
          # kb_variant =
          # kb_model =
          # kb_options = caps:swapescape # Done by evremap instead
          # kb_rules =
          numlock_by_default = true;

          follow_mouse = 1;

          touchpad = {
            natural_scroll = true;
            disable_while_typing = false;
          };
          sensitivity = 0; # https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration
        };

        # Layout
        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
        };

        misc = {
          vrr = 0; # Adaptive Sync. 0 - off, 1 - on, 2 - fullscreen
          disable_hyprland_logo = false;
          disable_splash_rendering = false;
          new_window_takes_over_fullscreen = 2; # 0 - behind, 1 - takes over, 2 - unfullscreen/unmaxize
        };

        # https://wiki.hyprland.org/Configuring/Window-Rules/
        # List windows with `hyprctl clients`
        windowrulev2 = [
          # Float
          "float,class:(thunar),title:(File Operation Progress)"
          "float,title:((Add|Open).*(File|Folder))"
          "float,title:((Select).*(open))"

          # Maximised
          "bordercolor rgb(FF0000) rgb(00FF00) rgb(0000FF) 45deg,fullscreen:1"
          "bordersize 2,fullscreen:1"

          # PIP
          "tag +PIP,title:(Picture-in-Picture)"
          "float,tag:PIP"
          "size 30% 30%,tag:PIP*"
          "move 100%-w-3 100%-w-3,tag:PIP"
          "keepaspectratio,tag:PIP*"
          "noblur,tag:PIP"
          "pin,tag:PIP,floating:1"
          "opacity 0.3 1,tag:PIP,floating:1"

          # Idle
          "idleinhibit fullscreen, class:^(*)$"
          "idleinhibit fullscreen, title:^(*)$"
          "idleinhibit fullscreen, fullscreen:1"
        ];

        # Execute your favorite apps at launch
        exec-once = [
          # "hypridle"
          "waybar"
        #   "hyprpaper"
        #   "dunst"
        #   "systemctl --user start hyprpolkitagent"
        #   "wl-clip-persist --clipboard regular"
        #   "wl-paste --watch cliphist store"
        ];
      };
    };
  };
}
