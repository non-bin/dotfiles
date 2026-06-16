{
  lib,
  config,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    gesture =
      let
        mkLuaInlineFunction = x: lib.generators.mkLuaInline ("function () " + x + " end");
      in
      [
        {
          fingers = 3;
          direction = "horizontal";
          scale = 2;
          action = "workspace";
        }
        {
          fingers = 3;
          direction = "up";
          action = mkLuaInlineFunction "hl.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+')";
        }
        {
          fingers = 3;
          direction = "down";
          action = mkLuaInlineFunction "hl.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-')";
        }
        {
          fingers = 4;
          direction = "down";
          action = mkLuaInlineFunction "hl.exec_cmd('playerctl play-pause')";
        }
        {
          fingers = 4;
          direction = "right";
          action = mkLuaInlineFunction "hl.exec_cmd('playerctl previous')";
        }
        {
          fingers = 4;
          direction = "left";
          action = mkLuaInlineFunction "hl.exec_cmd('playerctl next')";
        }
        {
          fingers = 4;
          direction = "right";
          mods = "SHIFT";
          action = mkLuaInlineFunction "hl.exec_cmd('playerctl position 10-')";
        }
        {
          fingers = 4;
          direction = "left";
          mods = "SHIFT";
          action = mkLuaInlineFunction "hl.exec_cmd('playerctl position 10+')";
        }
      ];

    # https://wiki.hypr.land/Configuring/Basics/Binds/
    # https://wiki.hypr.land/Configuring/Basics/Dispatchers/
    # use `wev` to figgure out what key is what
    bind =
      let
        genBindAttrs = keys: dispatcher: {
          _args = [
            keys
            (lib.generators.mkLuaInline dispatcher)
          ];
        };
        genMouseBindAttrs = keys: dispatcher: {
          _args = [
            keys
            (lib.generators.mkLuaInline dispatcher)
            { mouse = true; }
          ];
        };
        genRepeatingBindAttrs = keys: dispatcher: {
          _args = [
            keys
            (lib.generators.mkLuaInline dispatcher)
            { repeating = true; }
          ];
        };
      in
      [
        # Mouse movement
        (genMouseBindAttrs "META + mouse:272" "hl.dsp.window.drag()") # META + LMB: Move a window
        (genMouseBindAttrs "META + mouse:273" "hl.dsp.window.resize()") # META + RMB: Resize a window

        # Actions
        (genBindAttrs "META + RETURN" "hl.dsp.exec_cmd('ghostty +new-window')")
        (genBindAttrs "META + C" "hl.dsp.exec_cmd('code')")
        (genBindAttrs "META + E" "hl.dsp.exec_cmd('thunar')")
        (genBindAttrs "META + SPACE" "hl.dsp.exec_cmd('wofi --insensitive --show drun')") # Open wofi to run .desktop entries
        (genBindAttrs "META + ALT + SPACE" "hl.dsp.exec_cmd('wofi --insensitive --show run')") # Open to run from path
        (genBindAttrs "META + B" "hl.dsp.exec_cmd('firefox')")
        (genBindAttrs "META + S" "hl.dsp.exec_cmd('spotify')")
        (genBindAttrs "META + V" "hl.dsp.exec_cmd('cliphist list | wofi -S dmenu | cliphist decode | wl-copy')")
        (genBindAttrs "META + O" "hl.dsp.exec_cmd('orca-slicer')")
        (genBindAttrs "META + N" "hl.dsp.exec_cmd('obsidian')")
        (genBindAttrs "META + ALT + B" "hl.dsp.exec_cmd('pkill -USR1 waybar || ~/dotfiles/scripts/reload-waybar.sh')") # Toggle waybar

        # Session
        (genBindAttrs "CTRL + ALT + DELETE" "hl.dsp.exec_cmd('wlogout')")
        (genBindAttrs "META + SHIFT + ALT + B" "hl.dsp.exec_cmd('~/dotfiles/scripts/reload-waybar.sh')")
        (genBindAttrs "META + SHIFT + ALT + W" "hl.dsp.exec_cmd('~/dotfiles/scripts/reload-hyprpaper.sh')")

        (genBindAttrs "META + Q" "hl.dsp.window.close()")
        (genBindAttrs "META + ALT + Q" "hl.dsp.window.kill()")
        (genBindAttrs "META + ALT + T" "hl.dsp.window.float()")
        (genBindAttrs "META + P" "hl.dsp.window.pseudo()")
        (genBindAttrs "META + M" "hl.dsp.window.fullscreen_state({internal = 1, client = 1, action = 'toggle'})") # Toggle maximised
        (genBindAttrs "META + F" "hl.dsp.window.fullscreen_state({internal = 2, client = 2, action = 'toggle'})") # Toggle fullscreen
        (genBindAttrs "META + ALT + F" "hl.dsp.window.fullscreen_state({internal = 2, client = 0})") # Make window fullscreen, but make the app think it's tiled
        (genBindAttrs "META + ALT + M" "hl.dsp.window.fullscreen_state({internal = 1, client = 2})") # Make window maximised, but make the app think it's fullscreen
        (genBindAttrs "META + ALT + N" "hl.dsp.window.fullscreen_state({internal = 0, client = 2})") # Make window tiled, but make the app think it's fullscreen
        (genBindAttrs "META + ALT + S" "hl.dsp.window.toggle_swallow()") # Make swallowed windows visible

        (genBindAttrs "META + ALT + P" ''
          function()
            local w = hl.get_active_window()
            for index, value in ipairs(w.tags) do
              if value == 'PIP*' then
                hl.dispatch(hl.dsp.window.pin({ action = 'off', window = w }))
                hl.dispatch(hl.dsp.window.float({ action = 'off', window = w }))
                hl.dispatch(hl.dsp.window.tag({ tag = '-PIP*', window = w }))
                return
              end
            end

            hl.dispatch(hl.dsp.window.tag({ tag = '+PIP*', window = w }))
            hl.dispatch(hl.dsp.window.float({ action = 'on', window = w }))
            hl.dispatch(hl.dsp.window.pin({ action = 'on', window = w }))
            hl.dispatch(hl.dsp.window.move({ x = w.monitor.size.width - w.size.x - 640, y = w.monitor.size.height - w.size.y - 400, window = w }))
          end
        '')

        # Media
        (genBindAttrs "XF86AudioMute" "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')")
        (genBindAttrs "XF86AudioPlay" "hl.dsp.exec_cmd('playerctl play-pause')")
        (genBindAttrs "XF86AudioPrev" "hl.dsp.exec_cmd('playerctl previous')")
        (genBindAttrs "XF86AudioNext" "hl.dsp.exec_cmd('playerctl next')")
        (genBindAttrs "ALT+ XF86AudioPrev" "hl.dsp.exec_cmd('playerctl position 10-')")
        (genBindAttrs "ALT+ XF86AudioNext" "hl.dsp.exec_cmd('playerctl position 10+')")

        # Volume
        (genRepeatingBindAttrs "XF86AudioLowerVolume" "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')")
        (genRepeatingBindAttrs "XF86AudioRaiseVolume" "hl.dsp.exec_cmd('wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+')") # Limit volume to 150%

        # Screen brightness
        (genRepeatingBindAttrs "XF86MonBrightnessUp" "hl.dsp.exec_cmd('brightnessctl --min-value=4000 --exponent=3 s +10%')")
        (genRepeatingBindAttrs "XF86MonBrightnessDown" "hl.dsp.exec_cmd('brightnessctl --min-value=4000 --exponent=3 s 10%-')")

        # Screenshot
        (genBindAttrs "Print" "hl.dsp.exec_cmd('${config.home.homeDirectory}/dotfiles/scripts/screenshot.sh')")
        (genBindAttrs "META + Print" "hl.dsp.exec_cmd('${config.home.homeDirectory}/dotfiles/scripts/screenshot.sh -e')") # Edit
        (genBindAttrs "CTRL + Print" "hl.dsp.exec_cmd('hyprpicker -a')")

        # Move focus with META + arrow keys
        (genBindAttrs "META + H" "hl.dsp.focus({direction = 'l'})")
        (genBindAttrs "META + L" "hl.dsp.focus({direction = 'r'})")
        (genBindAttrs "META + K" "hl.dsp.focus({direction = 'u'})")
        (genBindAttrs "META + J" "hl.dsp.focus({direction = 'd'})")

        # Move window
        (genBindAttrs "META + SHIFT + H" "hl.dsp.window.move({direction = 'l'})")
        (genBindAttrs "META + SHIFT + L" "hl.dsp.window.move({direction = 'r'})")
        (genBindAttrs "META + SHIFT + K" "hl.dsp.window.move({direction = 'u'})")
        (genBindAttrs "META + SHIFT + J" "hl.dsp.window.move({direction = 'd'})")

        # Switch workspaces
        (genBindAttrs "META + Y" "hl.dsp.focus({workspace = 'r-1'})")
        (genBindAttrs "META + O" "hl.dsp.focus({workspace = 'r+1'})")

        # Move active window to a workspace
        (genBindAttrs "META + SHIFT + Y" "hl.dsp.window.move({workspace = '-1'})")
        (genBindAttrs "META + SHIFT + O" "hl.dsp.window.move({workspace = '+1'})")

        # Move active window to a workspace and don't move focus
        (genBindAttrs "META + ALT + Y" "hl.dsp.window.move({workspace = '-1', follow = false})")
        (genBindAttrs "META + ALT + O" "hl.dsp.window.move({workspace = '+1', follow = false})")

        (genBindAttrs "META + 0" "hl.dsp.workspace.toggle_special('special')")
        (genBindAttrs "META + SHIFT + SEMICOLON" "hl.dsp.layout('rotatesplit', 90)")
        (genBindAttrs "META + ALT + SEMICOLON" "hl.dsp.layout('movetoroot')")
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            (genBindAttrs "META + code:1${toString i}" "hl.dsp.focus({workspace = '${toString ws}'})") # Switch workspaces with META + [0-9]
            (genBindAttrs "META + SHIFT + code:1${toString i}" "hl.dsp.window.move({workspace = '${toString ws}'})"

            ) # Move active window to a workspace with META + SHIFT + [0-9]
            (genBindAttrs "META + SHIFT + code:1${toString i}" "hl.dsp.window.move({workspace = '${toString ws}', follow = false})"

            ) # Move active window to a workspace with META + alt + [0-9] DONT MOVE FOCUS
          ]
        ) 9
      ));
  };
}
