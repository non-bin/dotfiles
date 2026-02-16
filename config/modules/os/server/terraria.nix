{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  services.terraria = {
    enable = true;
    dataDir = "/mnt/appdata/terraria";
    openFirewall = true;
    password = "daqawa12";
    worldPath = "/home/alice/Downloads/The_Discharge_of_Bad_Times.wld";
  };
}
