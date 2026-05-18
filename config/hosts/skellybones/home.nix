{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/home/personal.nix

    ../../modules/home/personal/minecraft.nix
    ../../modules/home/personal/ksp.nix
  ];
}
