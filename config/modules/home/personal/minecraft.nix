{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ../common/java.nix ];

  home.packages = with pkgs; [ prismlauncher ];
}
