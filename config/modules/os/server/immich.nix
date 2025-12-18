{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [ ];

  services = {
    immich = {
      enable = true;
      host = "0.0.0.0";
      port = 2283;
      openFirewall = true;
      mediaLocation = "/mnt/photos/library";
      settings.server.externalDomain = "https://immich.jacka.net.au";
    };
    homepage-dashboard = {
      # Find your API key under Account Settings > API Keys. The key should have the server.statistics permission
      environmentFiles = [ "/home/${user.name}/.immich.env" ]; # Must be manually created, containing `HOMEPAGE_VAR_IMMICH_APIKEY=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa`. Sad I know
      services."Media Library"."Immich" = {
        icon = "immich";
        href = "https://immich.jacka.net.au/";
        description = "Photo Library";
        server = "local";
        siteMonitor = "http://localhost:2283";
        widget = {
          type = "immich";
          url = "http://localhost:2283";
          key = "{{HOMEPAGE_VAR_IMMICH_APIKEY}}";
          version = 2;
        };
      };
    };
  };
}
