{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      settings = {
        # https://wiki.hyprland.org/Configuring/Binds/

        "$mod" = "META";

        # Non-repeating
        bind =
        [
          # Actions
          "$mod, RETURN, exec, alacritty # Open Alactritty"
          "$mod, C, exec, gtk-launch codium-wayland # /usr/share/applications/"
          "$mod, G, exec, gtk-launch GitKraken"
          "$mod, E, exec, ~/.config/ml4w/settings/filemanager.sh # Opens the filemanager"
          "$mod, Super_L, exec, rofi -show drun # Open rofi to run .desktop entries"
          "$mod, SPACE, exec, rofi -show run # Open to run from path"
          "$mod, B, exec, ~/.config/ml4w/settings/browser.sh # Opens the browser"
          "$mod ALT, M, exec, gtk-launch org.polymc.PolyMC # Minecraft Launcher"
          "$mod SHIFT, M, exec, polymc -l asd # Minecraft"
          "$mod, S, exec, spotify-launcher"
          "$mod, V, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"

          "$mod SHIFT ALT, M, exit # Exit Hyprland"
          "$mod SHIFT ALT, B, exec, ~/.config/ml4w/scripts/reload-waybar.sh # Reload Waybar"
          "$mod SHIFT ALT, W, exec, ~/.config/ml4w/scripts/reload-hyprpaper.sh # Reload hyprpaper after a changing the wallpaper"

          "$mod, Q, killactive # Close current window"
          "$mod, T, togglefloating # Toggle between tiling and floating window"
          "$mod, P, pin # Toggle between tiling and floating window"
          "$mod, F, fullscreen, 0 # Open the window in fullscreen"
          "$mod, M, fullscreen, 1 # Open the window maximised"
          ", Print, exec, grim -t png -g \"$(slurp -d)\" \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H.%M.%S).png\" | wl-copy # Screenshot"
          "$mod, Print, exec, grim -t png -g \"$(slurp -d)\" \"/tmp/screenshot.png\" && swappy -f \"/tmp/screenshot.png\" -o \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H.%M.%S).png" # Screenshot
          "$mod, P, pseudo, # dwindle"
          "$mod, J, togglesplit, # dwindle"
          "$mod, L, exec, loginctl lock-session"

          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l # Move focus left"
          "$mod, right, movefocus, r # Move focus right"
          "$mod, up, movefocus, u # Move focus up"
          "$mod, down, movefocus, d # Move focus down"

          # Move window
          "$mod SHIFT, left, movewindow, l # Move focus left"
          "$mod SHIFT, right, movewindow, r # Move focus right"
          "$mod SHIFT, up, movewindow, u # Move focus up"
          "$mod SHIFT, down, movewindow, d # Move focus down"

          # Screenshot
          # add --cursor flag to include cursor also, --freeze flag to freeze before selection
          ", Print, exec, grimblast --notify copysave screen # Entire screen + clipboard copy"
          "$mod, Print, exec, grimblast --notify copysave active # current Active window only + clipboard copy"
          "$mod ALT, Print, exec, grimblast --notify copysave area # Select area to take screenshot"

          # Switch workspaces with mod + [0-9]
          "$mod, bracketright, workspace, +1 # Switch to workspace right"
          "$mod, bracketleft, workspace, -1 # Switch to workspace left"

          # Move active window to a workspace with mod + SHIFT + [0-9]
          "$mod SHIFT, bracketright, movetoworkspace, +1 #  Move window to workspace right"
          "$mod SHIFT, bracketleft, movetoworkspace, -1 #  Move window to workspace left"

          # Move active window to a workspace with mod + alt + [0-9] DONT MOVE FOCUS
          "$mod ALT, bracketright, movetoworkspacesilent, +1 #  Move window to workspace right"
          "$mod ALT, bracketleft, movetoworkspacesilent, -1 #  Move window to workspace left"
        ] ++ (
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"              # Switch workspaces with mod + [0-9]
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"  # Move active window to a workspace with mod + SHIFT + [0-9]
              "$mod ALT, code:1${toString i}, movetoworkspace, ${toString ws}"    # Move active window to a workspace with mod + alt + [0-9] DONT MOVE FOCUS
            ]
          ) 9)
        );

        # Repeating
        binde = [
          # Volume
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+" # Limit volume to 150%
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Screen brightness
          ", XF86MonBrightnessUp, exec, brightnessctl --exponent=3 s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl --exponent=3 s 10%-"
        ];

        # Mouse
        # Move/resize windows with mod + LMB/RMB and dragging
        bindm = [
          "$mod, mouse:272, movewindow" # Move window
          "$mod, mouse:273, resizewindow" # Resize window
        ];
      };
    };
  };
}
