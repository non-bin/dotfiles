{
  pkgs,
  ...
}:

{
  imports = [ ../common/java.nix ];

  home.packages = with pkgs; [ prismlauncher ]; # TODO: declarative
}
