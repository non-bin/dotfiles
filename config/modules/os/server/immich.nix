{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;
    mediaLocation = "/mnt/photos/library";
    settings.server.externalDomain = "https://immich.jacka.net.au";
  };
}
