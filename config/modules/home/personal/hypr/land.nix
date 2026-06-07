{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./binds.nix
  ];

  wayland.windowManager = {
    hyprland = {
      enable = true;

      # Use the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # Make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      # Tell systemd to import the environment, otherwise it won't find some binaries
      systemd.variables = [ "--all" ];

      configType = "lua";

      settings = {
        # https://wiki.hypr.land/Configuring/Basics/Monitors/
        # hyprctl monitors all
        monitor = [
          {
            output = "eDP-1";
            mode = "2560x1600@165";
            position = "auto";
            scale = 1.333333;
          }
          {
            output = ""; # Fallback
            mode = "preferred";
            position = "auto";
            scale = 1;
            # mirror = "eDP-1";
          }
          # hyprctl eval 'hl.monitor({output = "", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1"})'
          # hyprctl eval 'hl.monitor({output = "", mode = "preferred", position = "auto", scale = 1})'
        ];

        config = {
          # https://wiki.hypr.land/Configuring/Basics/Variables/#general
          general = {
            gaps_in = 2;
            gaps_out = 4;
            gaps_workspaces = 10;
            border_size = 0;
            "col.active_border" = "rgb(FFA348)";
            "col.inactive_border" = "rgb(595959)";
            layout = "dwindle";
            no_focus_fallback = true;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
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
            border_part_of_window = false;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
          gestures = {
            workspace_swipe_forever = true;
            workspace_swipe_distance = 400;
            workspace_swipe_direction_lock = false;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#input
          input = {
            kb_layout = "us";
            numlock_by_default = true;
            follow_mouse = 1; # Cursor movement will always change focus to the window under the cursor
            special_fallthrough = true;

            # https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
            };
            sensitivity = 0; # https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration
          };

          # https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
          dwindle = {
            preserve_split = true;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#misc
          misc = {
            vrr = 3; # Adaptive Sync. 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with video or game content type
            disable_hyprland_logo = false;
            disable_splash_rendering = false;
            force_default_wallpaper = 2;
            on_focus_under_fullscreen = 2; # 0 - behind, 1 - takes over, 2 - unfullscreen/unmaxize
            enable_swallow = true;
            swallow_regex = "com.mitchellh.ghostty";
            initial_workspace_tracking = 2; # windows and children will open on the workspace they were invoked
            middle_click_paste = false;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#xwayland
          xwayland = {
            force_zero_scaling = true;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#binds
          binds = {
            allow_pin_fullscreen = true;
          };

          # https://wiki.hypr.land/Configuring/Basics/Variables/#ecosystem
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
        };

        # https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
        curve = {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.05
                ]
              ];
            }
          ];
        };

        animation = [
          {
            enabled = true;
            leaf = "windows";
            speed = 7;
            bezier = "myBezier";
          }
          {
            enabled = true;
            leaf = "windowsOut";
            speed = 7;
            bezier = "default";
            style = "popin 80%";
          }
          {
            enabled = true;
            leaf = "border";
            speed = 10;
            bezier = "default";
          }
          {
            enabled = true;
            leaf = "borderangle";
            speed = 8;
            bezier = "default";
          }
          {
            enabled = true;
            leaf = "fade";
            speed = 7;
            bezier = "default";
          }
          {
            enabled = true;
            leaf = "workspaces";
            speed = 6;
            bezier = "default";
          }
        ];

        # https://wiki.hypr.land/Configuring/Basics/Window-Rules/
        # List windows with `hyprctl clients`
        window_rule = [
          # Float
          {
            match = {
              class = "thunar";
              title = "File Operation Progress";
            };
            float = true;
          }
          {
            match = {
              title = "(Add|Open).*(File|Folder)";
            };
            float = true;
          }
          {
            match = {
              title = "((Add|Open).*(File|Folder))|((Select).*(open))";
            };
            float = true;
          }

          # Maximised
          {
            match = {
              fullscreen = true;
            };
            border_color = {
              colors = [
                "rgb(FF0000)"
                "rgb(00FF00)"
                "rgb(0000FF)"
              ];
              angle = 45;
            };
            border_size = 2;
          }

          # PIP
          {
            match = {
              title = "Picture-in-Picture";
            };
            tag = "+PIP";
          }
          {
            match = {
              tag = "PIP";
            };

            # Dynamic https://wiki.hypr.land/Configuring/Basics/Window-Rules/#dynamic-effects
            keep_aspect_ratio = true;
            opacity = "0.3 1";

            # Static https://wiki.hypr.land/Configuring/Basics/Window-Rules/#static-effects
            float = true;
            pin = true;
            move = [
              "monitor_w-window_w"
              "monitor_h-window_h"
            ];
          }

          # Idle
          {
            match = {
              class = "."; # Everything
            };
            idle_inhibit = "fullscreen";
          }
        ];

        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.dispatch(hl.dsp.focus({ workspace = 2 }))
                hl.exec_cmd("waybar")
                hl.exec_cmd("~/dotfiles/scripts/reload-hyprpaper.sh -w")
                hl.exec_cmd("spotify", {workspace = "1 silent"})
                hl.exec_cmd("firefox", {workspace = "2 silent"})
              end
            '')
          ];
        };

        env =
          let
            genEnvAttrs = var: val: {
              _args = [
                var
                val
              ];
            };
          in
          [
            # Electron
            (genEnvAttrs "ELECTRON_OZONE_PLATFORM_HINT" "wayland")

            # XDG Desktop Portal
            (genEnvAttrs "XDG_CURRENT_DESKTOP" "Hyprland")
            (genEnvAttrs "XDG_SESSION_TYPE" "wayland")
            (genEnvAttrs "XDG_SESSION_DESKTOP" "Hyprland")

            # QT
            (genEnvAttrs "QT_QPA_PLATFORM" "wayland;xcb")
            (genEnvAttrs "QT_QPA_PLATFORMTHEME" "qt6ct")
            (genEnvAttrs "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1")
            (genEnvAttrs "QT_AUTO_SCREEN_SCALE_FACTOR" "1")

            # GTK
            (genEnvAttrs "GDK_SCALE" "1")

            # Gnome

            # Mozilla
            (genEnvAttrs "MOZ_ENABLE_WAYLAND" "1")

            # Set the cursor size for xcursor
            (genEnvAttrs "XCURSOR_SIZE" "24")

            # Disable appimage launcher by default
            (genEnvAttrs "APPIMAGELAUNCHER_DISABLE" "1")

            # OZONE
            (genEnvAttrs "OZONE_PLATFORM" "wayland")

            # For KVM virtual machines
            # (genEnvAttrs "WLR_NO_HARDWARE_CURSORS" "1")
            # (genEnvAttrs "WLR_RENDERER_ALLOW_SOFTWARE" "1")

            # NVIDIA https://wiki.hyprland.org/Nvidia/
            # (genEnvAttrs "LIBVA_DRIVER_NAME" "nvidia")
            # (genEnvAttrs "GBM_BACKEND" "nvidia-drm")
            # (genEnvAttrs "__GLX_VENDOR_LIBRARY_NAME" "nvidia")
            # (genEnvAttrs "__GL_VRR_ALLOWED" "1")
            # (genEnvAttrs "WLR_DRM_NO_ATOMIC" "1")
          ];
      };
    };
  };
}
