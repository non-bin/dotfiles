{ config, lib, pkgs, ... }:

{
  imports = [
    ../common/modules/samba.nix
    ../common/configuration.nix
  ];
}
