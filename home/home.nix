{ config, pkgs, ... }:

# home-manager.users.alice =
{
  imports = [
    ./hypr/hyprland.nix
    ./alacrity.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.sessionPath = [
    "$HOME/dotfiles/repos/dotfiles/scripts"
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    wget
    btop
    hyprpicker
    wev # Waykand event viewer

    slurp           # Reigeon selector
    grim            # Screenshot taker
    swappy          # Screenshot editor
    wl-clipboard

    kdePackages.ark # Archive manager
    gitkraken
    gnome-disk-utility
    orca-slicer
    qdirstat
    spotify
    vlc

    noto-fonts
    # nerd-fonts.caskaydia-cove
    # nerd-fonts.mononoki
    font-awesome

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];

  home.file = {
    ".aspell.conf".text = ''
    master en_AU
    extra-dicts en-computers.rws
    add-extra-dicts en_GB-science.rws
    '';
  };

  programs = {
    bash.enable = true;
    firefox.enable = true;
    wofi.enable = true;

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

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        yzhang.markdown-all-in-one
      ];
    };
  };

  services = {
    dunst.enable = true;
    cliphist.enable = true;
  };

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
