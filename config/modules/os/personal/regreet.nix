{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  environment.etc."wallpapers/lock.jpg" = {
    source = "/home/alice/wallpapers/lockscreen/calder-moore-scifi-elevator-fin.jpg";
    mode = "0644";
  };

  programs.regreet = {
    enable = true;
    font.package = pkgs.roboto;
    font.name = "Roboto";
    cursorTheme.package = pkgs.canta-theme;
    cursorTheme.name = "Canta";
    iconTheme.package = pkgs.canta-theme;
    iconTheme.name = "Canta";
    theme.package = pkgs.canta-theme;
    theme.name = "Canta";
    settings = {
      background = {
        path = "/etc/wallpapers/lock.jpg";
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };
}
