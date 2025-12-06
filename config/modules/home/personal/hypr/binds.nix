{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      settings = {
        # https://wiki.hyprland.org/Configuring/Binds/
        # use `wev` to figgure out what key is what

        "$mod" = "META";

        # Non-repeating
        bind = [
          # Actions
          "$mod, RETURN, exec, alacritty"
          "$mod, C, exec, code"
          "$mod, G, exec, gitkraken" # /usr/share/applications
          "$mod, E, exec, thunar" # Opens the filemanager
          "$mod, SPACE, exec, wofi --show drun" # Open wofi to run .desktop entries
          "$mod ALT, SPACE, exec, wofi --show run" # Open to run from path
          "$mod, B, exec, firefox" # Opens the browser
          "$mod ALT, M, exec, prismlauncher" # Minecraft Launcher
          "$mod SHIFT, M, exec, prismlauncher -l main" # Minecraft
          "$mod, S, exec, spotify"
          "$mod, V, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"
          "$mod, O, exec, orca-slicer"
          "$mod, N, exec, obsidian"

          "CTRL ALT ALT, DELETE, exec, wlogout"
          "$mod SHIFT ALT, B, exec, /home/alice/dotfiles/scripts/reload-waybar.sh"
          "$mod SHIFT ALT, W, exec, /home/alice/dotfiles/scripts/reload-hyprpaper.sh"

          "$mod, Q, killactive" # Close current window
          "$mod ALT, Q, forcekillactive" # Kill current window https://github.com/hyprwm/Hyprland/issues/9177
          "$mod, T, togglefloating" # Toggle between tiling and floating window
          "$mod, P, pseudo,"
          "$mod, F, fullscreen, 0" # Open the window in fullscreen
          "$mod, M, fullscreen, 1" # Open the window maximised
          "ALT, Print, exec, hyprpicker -a" # Pick colour

          "$mod ALT, P, tagwindow, +PIP*"
          "$mod ALT, P, setfloating"
          "$mod ALT, P, movewindow, r"
          "$mod ALT, P, movewindow, d"
          "$mod ALT, P, resizeactive, exact 30% 30%"
          "$mod ALT, P, setprop, noblur 1"
          "$mod ALT, P, pin"

          "$mod CTRL ALT, P, tagwindow, -PIP*"
          "$mod CTRL ALT, P, settiled"
          "$mod CTRL ALT, P, setprop, keepaspectratio unset"
          "$mod CTRL ALT, P, setprop, noblur unset"

          "$mod, J, togglesplit,"
          "$mod, L, exec, hyprlock --immediate & loginctl lock-session"

          # Media
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
          "SHIFT, XF86AudioPrev, exec, playerctl position 10-"
          "SHIFT, XF86AudioNext, exec, playerctl position 10+"

          # Screenshot (https://github.com/emersion/slurp/issues/16#issuecomment-3244586972)
          ## Save and copy to clipboard
          '', Print, exec, grim -t png -g "$(hyprctl clients -j | jq --argjson active $(hyprctl monitors -j | jq -c '[.[].activeWorkspace.id]') '.[] | select((.hidden | not) and (.workspace.id as $id | $active | contains([$id]))) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' -r | slurp -d)" "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H.%M.%S).png" | wl-copy''
          ## Open swappy to edit
          ''$mod, Print, exec, grim -t png -g "$(hyprctl clients -j | jq --argjson active $(hyprctl monitors -j | jq -c '[.[].activeWorkspace.id]') '.[] | select((.hidden | not) and (.workspace.id as $id | $active | contains([$id]))) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' -r | slurp -d)" "/tmp/screenshot.png" && swappy -f "/tmp/screenshot.png" -o "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H.%M.%S).png"''

          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l" # Move focus left
          "$mod, right, movefocus, r" # Move focus right
          "$mod, up, movefocus, u" # Move focus up
          "$mod, down, movefocus, d" # Move focus down

          # Move window
          "$mod SHIFT, left, movewindow, l" # Move focus left
          "$mod SHIFT, right, movewindow, r" # Move focus right
          "$mod SHIFT, up, movewindow, u" # Move focus up
          "$mod SHIFT, down, movewindow, d" # Move focus down

          # Move workspace to monitor
          "$mod ALT, left, moveworkspacetomonitor, +0 l" # Move focus left
          "$mod ALT, right, moveworkspacetomonitor, +0 r" # Move focus right
          "$mod ALT, up, moveworkspacetomonitor, +0 u" # Move focus up
          "$mod ALT, down, moveworkspacetomonitor, +0 d" # Move focus down

          # Switch workspaces with mod + [/]
          "$mod, bracketright, workspace, r+1" # Switch to workspace right
          "$mod, bracketleft, workspace, r-1" # Switch to workspace left

          # Move active window to a workspace with mod + SHIFT + [/]
          "$mod SHIFT, bracketright, movetoworkspace, +1" # Move window to workspace right
          "$mod SHIFT, bracketleft, movetoworkspace, -1" # Move window to workspace left

          # Move active window to a workspace and don't move focus with mod + alt + [/]
          "$mod ALT, bracketright, movetoworkspacesilent, +1" # Move window to workspace right
          "$mod ALT, bracketleft, movetoworkspacesilent, -1" # Move window to workspace left
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}" # Switch workspaces with mod + [0-9]
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}" # Move active window to a workspace with mod + SHIFT + [0-9]
              "$mod ALT, code:1${toString i}, movetoworkspacesilent, ${toString ws}" # Move active window to a workspace with mod + alt + [0-9] DONT MOVE FOCUS
              # "$mod CTRL ALT, code:1${toString i}, throwunfocused, ${toString ws}"    # Move active window to a workspace with mod + alt + [0-9] DONT MOVE FOCUS
            ]
          ) 9
        ));

        # Repeating
        binde = [
          # Volume
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+" # Limit volume to 150%

          # Screen brightness
          ", XF86MonBrightnessUp, exec, brightnessctl --min-value=235 --exponent=3 s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl --min-value=235 --exponent=3 s 10%-"
        ];

        # Mouse
        # Move/resize windows with mod + LMB/RMB and dragging
        bindm = [
          "$mod, mouse:272, movewindow" # Move window
          "$mod, mouse:273, resizewindow" # Resize window
          # TODO Volume
        ];
      };
    };
  };
}
