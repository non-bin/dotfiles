{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./ghostty.nix
    ./defaultApps.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    DEFAULT_BROWSER = "${lib.getExe pkgs.firefox}";
    BROWSER = "firefox";
    TERMINAL = "ghostty";
  };

  home.packages = with pkgs; [
    playerctl
    brightnessctl

    # Thumbnail providers
    ffmpegthumbnailer # Video
    poppler_gi # Adobe .pdf files
    freetype # Font files
    libgsf # .odf files
    nufraw-thumbnailer # .raw files
    evince # .pdf files
    # f3d # 3D files, includ1ing glTF, stl, step, ply, obj, fbx. # FIXME https://github.com/NixOS/nixpkgs/issues/540609

    slurp # Region selector
    grim # Screenshot taker
    swappy # Screenshot editor
    wl-clipboard

    kdePackages.ark # Archive manager
    gnome-disk-utility
    qdirstat
    vlc
    blueman

    noto-fonts
    nerd-fonts.caskaydia-cove
    nerd-fonts.mononoki
    font-awesome

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    pavucontrol # Audio settings
  ];

  home.file = {
    ".aspell.conf".text = ''
      master en_AU
      extra-dicts en-computers.rws
      add-extra-dicts en_GB-science.rws
    '';
  };

  programs = {
    firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
    wofi.enable = true; # Spotlight search
  };

  services = {
    dunst.enable = true; # Notification daemon
    cliphist.enable = true;
    wl-clip-persist.enable = true;
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
