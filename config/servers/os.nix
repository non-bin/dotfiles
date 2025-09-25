{ config, lib, pkgs, ... }:

{
  imports = [
    ../common/os.nix
    ./modules/os/homepage.nix
    ./modules/os/nginx.nix
  ];
}
