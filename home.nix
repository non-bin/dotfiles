# { inputs, lib, config, pkgs, ... }:
{ config, pkgs, ... }:

# home-manager.users.alice =
{
  # imports = [
  #   # ./hypr/hyprland.nix
  # ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.sessionPath = [
    "$HOME/dotfiles"
  ];

  programs = {
    bash = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      extraConfig = ''
        set autoindent expandtab tabstop=2 shiftwidth=2
        set number
        if &diff
          colorscheme blue
        endif
      '';
    };

    git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [ "gh:" "github:" ];
      };
    };

    alacritty = {
      enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    };
  };

  # wayland.windowManager = {
  #   hyprland = {
  #     enable = true;
  #     settings = {
  #       "monitor" = ",2560x1600@165.00,auto,1.333333";
  #       "$mod" = "ALT";
  #       bind =
  #       [
  #         "$mod, RETURN, exec, alacritty"
  #         "$mod, M, exit"
  #       ]
  #       ++ (
  #         # workspaces
  #         # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
  #         builtins.concatLists (builtins.genList (i:
  #           let ws = i + 1;
  #           in [
  #             "$mod, code:1${toString i}, workspace, ${toString ws}"
  #             "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
  #           ]
  #         ) 9)
  #       );
  #     };
  #   };
  # };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
