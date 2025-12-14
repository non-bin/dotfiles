{
  config,
  lib,
  pkgs,
  inputs,
  user,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_latest; # Sets the kernel version https://nixos.wiki/wiki/Linux_kernel

  systemd.oomd.enableUserSlices = true; # I don't remember why

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    trusted-users = [ "@wheel" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true; # Combine duplicates

    # List of binary cache URLs used to obtain pre-built binaries of Nix packages
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  users = {
    groups.${user.name}.gid = 1000;
    users.${user.name} = {
      uid = 1000;
      description = user.fullName;
      createHome = true;
      home = "/home/${user.name}";
      group = user.name;
      extraGroups = [
        "wheel"
        "networkmanager"
        "adbusers"
        "libvirtd"
        "docker"
        "kvm"
        "tty"
        "dialout"
      ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ user.sshPubKey ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh.enable = true;
  };
}
