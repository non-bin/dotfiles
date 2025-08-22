{ config, lib, pkgs, ... }:

{
  services.immich = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    # port = 2283;
    accelerationDevices = null; # null means all, [] means none
    # mediaLocation = "/data/photos" # Must be created manually unless it's the default /var/lib/immich
  };
}
