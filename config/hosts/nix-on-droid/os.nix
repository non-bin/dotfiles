{
  pkgs,
  user,
  ...
}:

{
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

      color0 = "#000000";
      color1 = "#e25d56";
      color2 = "#73ca50";
      color3 = "#e9bf57";
      color4 = "#4a88e4";
      color5 = "#915caf";
      color6 = "#23acdd";
      color7 = "#f0f0f0";
      color8 = "#777777";
      color9 = "#f36868";
      color10 = "#88db3f";
      color11 = "#f0bf7a";
      color12 = "#6f8fdb";
      color13 = "#e987e9";
      color14 = "#4ac9e2";
      color15 = "#FFFFFF";
    };
  };

  nix = {
    extraOptions = [
      "experimental-features = nix-command flakes"
      "connect-timeout = 5"
      "builders-use-substitutes = true"
    ];
  };

  system.stateVersion = user.stateVersion;
}
