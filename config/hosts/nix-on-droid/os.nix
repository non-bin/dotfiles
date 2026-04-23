{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  home-manager = {
    config = import ./home.nix;
    extraSpecialArgs = { inherit user; };
  };

  environment.packages = with pkgs; [
    git
    openssh
  ];

  user.shell = pkgs.zsh;

  time.timeZone = "Australia/Melbourne";

  terminal = {
    font = "${pkgs.nerd-fonts.caskaydia-cove}/share/fonts/truetype/NerdFonts/CaskaydiaCove/CaskaydiaCoveNerdFont-Regular.ttf";
    colors = {
      # https://nix-community.github.io/nix-on-droid/nix-on-droid-options.html#opt-terminal.colors
      background = "#000000";
      foreground = "#FFFFFF";
      cursor = "#FFFFFF";
    };
  };

  environment.etcBackupExtension = ".bak";
  nix.extraOptions = "experimental-features = nix-command flakes";

  # https://github.com/nix-community/nix-on-droid/issues/519
  build.activation.zz_unfuck_proot = ''
    echo "overwriting proot-static.new with old (and working) proot executable"
    cp -v /data/data/com.termux.nix/files/usr/bin/proot-static /data/data/com.termux.nix/files/usr/bin/.proot-static.new
  '';

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
