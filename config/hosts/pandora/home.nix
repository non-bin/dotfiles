{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/personal/base.nix
    ../../modules/home/common
  ];

  home.packages = with pkgs; [ libreoffice-fresh ];
}
