{
  pkgs,
  ...
}:

{
  imports = [
    ./regreet.nix
    ./btrbk.nix
  ];

  programs.nix-ld.enable = true; # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.libraries = with pkgs; [
    # https://github.com/cloudflare/workerd/discussions/1515#discussioncomment-10029667
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];

  boot.loader.grub.useOSProber = false;

  nixpkgs.config.android_sdk.accept_license = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    tumbler.enable = true; # Image thumbnails
    gvfs.enable = true; # Lets Thunar mount things

    locate = {
      enable = true;
      prunePaths = [
        "/snapshots"
        "/tmp"
        "/var/tmp"
        "/var/cache"
        "/var/lock"
        "/var/run"
        "/var/spool"
        "/nix/store"
        "/nix/var/log/nix"
      ];
    };

    cloudflare-warp = {
      enable = false;
    };

    logind = {
      settings.Login = {
        # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"
        HandleHibernateKey = "hibernate";
        HandleHibernateKeyLongPress = "ignore";
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore"; # When a second screen is attached
        # HandleLidSwitchExternalPower = ""; # Falls back to lidSwitch
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "ignore";
        HandleRebootKey = "reboot";
        HandleRebootKeyLongPress = "ignore";
        HandleSuspendKey = "suspend";
        HandleSuspendKeyLongPress = "ignore";
      };
    };

    evremap = {
      # Must enable and set device name in host config
      # enable = true;
      # settings.device_name = "Framework Laptop 16 Keyboard Module - ANSI Keyboard"; # evremap list-devices
      settings = {
        remap = [
          {
            input = [ "KEY_ESC" ];
            output = [ "KEY_CAPSLOCK" ];
          }
          {
            input = [ "KEY_CAPSLOCK" ];
            output = [ "KEY_ESC" ];
          }
        ];
      };
    };
  };
}
