{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      settings = {
        # unscale XWayland
        xwayland = {
          force_zero_scaling = true;
        };

        env = [
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

        exec = [ "hyprctl setcursor $HYPRCURSOR_THEME $HYPRCURSOR_SIZE" ];
      };
    };
  };
}
