{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ ckan ]; # TODO: declarative mods?
}
