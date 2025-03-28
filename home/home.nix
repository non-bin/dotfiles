{ config, pkgs, lib, ... }:

# home-manager.users.alice =
{
  imports = [
    ./hypr/land.nix
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
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.packages = with pkgs; [
    wget
    btop
    hyprpicker
    wev # Waykand event viewer
    zip
    unzip
    traceroute

    slurp           # Region selector
    grim            # Screenshot taker
    swappy          # Screenshot editor
    wl-clipboard
    solaar          # Logitech

    kdePackages.ark # Archive manager
    # gittyup
    gnome-disk-utility
    orca-slicer
    qdirstat
    spotify
    vlc
    inkscape-with-extensions
    filezilla
    blueman
    libreoffice-fresh
    kdePackages.kdenlive
    prismlauncher # Minecraft
    obsidian
    qbittorrent

    noto-fonts
    nerd-fonts.caskaydia-cove
    nerd-fonts.mononoki
    font-awesome

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    nodePackages_latest.nodejs
    deno

    quickemu
    jq
    ffmpeg
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
    # chromium.enable = true;
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
        credential.helper = "store";
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

  xdg.configFile."mimeapps.list".force = true; # Fix overwritten file
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain"="codium.desktop";
      "default-web-browser" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "inode/directory" = "thunar.desktop";
    };
  };

  home.file = {
    ".config/Thunar/uca.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <submenu></submenu>
        <unique-id>1735180505505982-1</unique-id>
        <command>/usr/bin/env alacritty --working-directory %f</command>
        <description>Example for a custom action</description>
        <range></range>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
      </actions>
    '';
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
