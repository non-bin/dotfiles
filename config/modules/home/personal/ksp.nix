{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ ckan ]; # TODO: declarative mods?
}
