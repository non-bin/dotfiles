{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  environment.systemPackages = with pkgs; [ docker-compose ];
}
