{ inputs, lib, config, pkgs, ... }:

# home-manager.users.alice =
{
  # imports = [
  #   ./hyprland.nix
  # ];

  wayland.windowManager = {
    hyprland = {
      enable = true;
      settings = {
        "monitor" = ",2560x1600@165.00,auto,1.333333";
        "$mod" = "ALT";
        bind =
        [
          "$mod, RETURN, exec, alacritty"
          "$mod, M, exit"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9)
        );
      };
    };
  };
}
