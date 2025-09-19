{ config, pkgs, lib, ... }:

{
  imports = [
    ../common/home.nix

    ./modules/home/hypr/land.nix
    ./modules/home/alacrity.nix
    ./modules/home/wlogout.nix
    ./modules/home/waybar/waybar.nix
    ./modules/home/code/code.nix
    ./modules/home/java.nix
    ./modules/home/obs.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    DEFAULT_BROWSER = "${lib.getExe pkgs.firefox}";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.packages = with pkgs; [
    playerctl
    brightnessctl
    wineWowPackages.waylandFull
    qemu

    # Thumbnail providers
    ffmpegthumbnailer # Video
    poppler_gi # Adobe .pdf files
    freetype # Font files
    libgsf # .odf files
    nufraw-thumbnailer # .raw files
    evince # .pdf files
    f3d # 3D files, including glTF, stl, step, ply, obj, fbx.

    hyprpicker
    wev # Waykand event viewer
    slurp           # Region selector
    grim            # Screenshot taker
    swappy          # Screenshot editor
    wl-clipboard
    solaar          # Logitech

    kdePackages.ark # Archive manager
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
    gimp

    noto-fonts
    nerd-fonts.caskaydia-cove
    nerd-fonts.mononoki
    font-awesome

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    nodejs #_latest
    deno
    gcc
    rustc
    cargo

    ffmpeg

    pavucontrol # Audio settings

    android-studio

    mesen # NES Emulator

    proxmark3
    qflipper
  ];

  home.file = {
    ".aspell.conf".text = ''
    master en_AU
    extra-dicts en-computers.rws
    add-extra-dicts en_GB-science.rws
    '';
  };

  programs = {
    firefox.enable = true;
    # chromium.enable = true;
    wofi.enable = true;
    bun.enable = true;
  };

  services = {
    dunst.enable = true; # Notification daemon
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
}
