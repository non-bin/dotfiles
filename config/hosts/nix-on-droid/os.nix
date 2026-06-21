{
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
    vim
  ];

  user.shell = "${pkgs.zsh}/bin/zsh";

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

  nix.extraOptions = "experimental-features = nix-command flakes";
  system.stateVersion = user.stateVersion;
}
