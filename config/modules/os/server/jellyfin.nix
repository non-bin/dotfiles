{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [ ];

  systemd.tmpfiles.rules = [ "f /etc/.jellyfin.env 0700 root root" ];

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      dataDir = "/mnt/appdata/jellyfin";
    };

    homepage-dashboard = {
      environmentFiles = [ "/etc/.jellyfin.env" ]; # Must be manually created, containing `HOMEPAGE_VAR_JELLYFIN_APIKEY=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa`. Sad I know
      services."Media Library"."Jellyfin" = {
        icon = "jellyfin";
        href = "https://jellyfin.jacka.net.au/";
        description = "Media Player";
        server = "local";
        siteMonitor = "http://localhost:8096";
        widget = {
          type = "jellyfin";
          url = "http://localhost:8096";
          key = "{{HOMEPAGE_VAR_JELLYFIN_APIKEY}}";
          enableBlocks = true;
          enableNowPlaying = true;
          enableUser = true;
          showEpisodeNumber = true;
          expandOneStreamToTwoRows = false;
        };
      };
    };
  };
}
