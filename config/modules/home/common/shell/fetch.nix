{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.fastfetch = {
    enable = true;
  };
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "xenogender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
      };
      backend = "fastfetch";
      args = null;
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };
}
