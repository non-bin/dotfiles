{ config, pkgs, lib, ... }:

# home-manager.users.alice =
{
  imports = [
    ./hypr/hyprland.nix
    ./alacrity.nix
    ./zsh.nix
    ./wlogout.nix
    ./waybar/waybar.nix
    ./code/code.nix
    ./java.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.sessionPath = [
    "$HOME/dotfiles/scripts"
  ];
  home.sessionVariables = {
    SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt";
    NIXOS_OZONE_WL = "1";
    DEFAULT_BROWSER = "${lib.getExe pkgs.firefox}";
  };

  home.packages = with pkgs; [
    wget
    btop
    hyprpicker
    wev # Waykand event viewer
    zip
    unzip

    slurp           # Region selector
    grim            # Screenshot taker
    swappy          # Screenshot editor
    wl-clipboard

    kdePackages.ark # Archive manager
    # gittyup
    gnome-disk-utility
    orca-slicer
    qdirstat
    spotify
    vlc
    inkscape-with-extensions
    filezilla

    noto-fonts
    nerd-fonts.caskaydia-cove
    nerd-fonts.mononoki
    font-awesome

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    nodePackages_latest.nodejs
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
    chromium.enable = true;
    wofi.enable = true;
    bun.enable = true;

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
      delta.enable = true; # Syntax hilighting
      extraConfig = {
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [ "gh:" "github:" ];
      };
      userEmail = "jacka.alice@gmail.com";
      userName = "Alice Jacka";
    };
  };

  services = {
    dunst.enable = true;
    cliphist.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
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
