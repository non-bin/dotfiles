{
  pkgs,
  inputs,
  user,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_latest; # Sets the kernel version https://nixos.wiki/wiki/Linux_kernel

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # For nixd
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
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
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
        "samba"
      ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ user.sshKeys.personal ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.Macs = [ "hmac-sha2-256" ]; # For cloudflared ssh https://github.com/cloudflare/cloudflared/issues/1198
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
