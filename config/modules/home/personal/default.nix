{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hypr
    ./code
    ./formatters
    ./base.nix
    ./obs.nix
  ];

  home.packages = with pkgs; [
    # wineWowPackages.waylandFull
    qemu

    hyprpicker
    wev # Waykand event viewer
    solaar # Logitech

    orca-slicer
    spotify
    vlc
    inkscape-with-extensions
    filezilla
    libreoffice-fresh
    #kdePackages.kdenlive
    obsidian
    qbittorrent
    gimp

    nodejs # _latest
    deno
    gcc
    rustc
    cargo

    ffmpeg

    # android-studio
    android-tools # adb etc

    mesen # NES Emulator

    discord

    piper
  ];

  programs = {
    bun.enable = true;
  };
}
