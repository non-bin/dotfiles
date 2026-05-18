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
}
