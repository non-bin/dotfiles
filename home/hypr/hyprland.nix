{ inputs, lib, config, pkgs, ... }:

# home-manager.users.alice =
{
  imports = [
    ./hyprland/binds.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  wayland.windowManager = {
    hyprland = {
      enable = true;

      # Tell systemd to import the environment, otherwise it won't find some binaries
      systemd.variables = ["--all"];
      settings = {
        "monitor" = ",2560x1600@165.00,auto,1.333333";

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
          vrr = 1; # Adaptive Sync. 0 - off, 1 - on, 2 - fullscreen
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
          "float,title:(Picture-in-Picture)"
          "move 100%-w-3 100%-w-3,title:(Picture-in-Picture)"
          "size 30% 30%,title:(Picture-in-Picture)"
          "keepaspectratio,title:(Picture-in-Picture)"
          "noblur,title:(Picture-in-Picture)"
          "pin,title:(Picture-in-Picture),floating:1"
          "opacity 0.3 1,title:(Picture-in-Picture),floating:1"

          # Idle
          "idleinhibit fullscreen, class:^(*)$"
          "idleinhibit fullscreen, title:^(*)$"
          "idleinhibit fullscreen, fullscreen:1"
        ];

        # unscale XWayland
        xwayland = {
          force_zero_scaling = true;
        };

        env = [
          "XCURSOR_SIZE,24"

          # Electron
          "ELECTRON_OZONE_PLATFORM_HINT,wayland"

          # XDG Desktop Portal
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"

          # QT
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"

          # GTK
          "GDK_SCALE,1"

          # Gnome

          # Mozilla
          "MOZ_ENABLE_WAYLAND,1"

          # Set the cursor size for xcursor
          "XCURSOR_SIZE,24"

          # Disable appimage launcher by default
          "APPIMAGELAUNCHER_DISABLE,1"

          # OZONE
          "OZONE_PLATFORM,wayland"

          # For KVM virtual machines
          # WLR_NO_HARDWARE_CURSORS, 1
          # WLR_RENDERER_ALLOW_SOFTWARE, 1

          # NVIDIA https://wiki.hyprland.org/Nvidia/
          # LIBVA_DRIVER_NAME,nvidia
          # GBM_BACKEND,nvidia-drm
          # __GLX_VENDOR_LIBRARY_NAME,nvidia
          # __GL_VRR_ALLOWED,1
          # WLR_DRM_NO_ATOMIC,1
        ];

        exec = [
          ''gsettings set org.gnome.desktop.interface gtk-theme "Adwaita:dark"''   # for GTK3 apps
          ''gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"'' # for GTK4 apps
        ];

        # Execute your favorite apps at launch
        # exec-once = [
        #   "waybar"
        #   "hyprpaper"
        #   "dunst"
        #   "hypridle"
        #   "systemctl --user start hyprpolkitagent"
        #   "wl-clip-persist --clipboard regular"
        #   "wl-paste --watch cliphist store"
        # ];
      };
    };
  };
}
