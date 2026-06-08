{
  pkgs,
  ...
}:
{
  imports = [ ../../modules/home/server.nix ];

  home.packages = with pkgs; [ libreoffice-fresh ];
}
