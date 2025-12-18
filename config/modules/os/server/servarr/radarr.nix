{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./prowlarr.nix
    ../qbt.nix

    ../nginx.nix
  ];

  age.secrets.radarr = {
    rekeyFile = ./radarr.age;
    generator.script =
      { pkgs, ... }:
      ''key="$(${pkgs.openssl}/bin/openssl rand -hex 16)" && echo "RADARR__AUTH__APIKEY=$key" && echo "HOMEPAGE_VAR_RADARR_APIKEY=$key"''; # 32 hex chars
  };

  services = {
    radarr = {
      enable = true;
      openFirewall = true;
      environmentFiles = [ config.age.secrets.radarr.path ];
      dataDir = "/mnt/appdata/radarr";
      settings = {
        auth = {
          enable = true;
          method = "Forms";
          required = "DisabledForLocalAddresses";
        };
        server = {
          port = 7878;
          bindAddress = "*";
          urlBase = "/radarr/";
          enableSSL = false;
        };
      };
    };

    homepage-dashboard = {
      environmentFiles = [ config.age.secrets.radarr.path ];
      services."Media Finders"."Radarr" = {
        icon = "radarr";
        href = "/radarr";
        description = "Movie Finder";
        server = "local";
        siteMonitor = "http://localhost:7878";
        widget = {
          type = "radarr";
          url = "http://localhost:7878";
          key = "{{HOMEPAGE_VAR_RADARR_APIKEY}}";
          enableQueue = true;
        };
      };
    };

    nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/radarr/".proxyPass =
      "http://localhost:7878/radarr/";
  };
}
