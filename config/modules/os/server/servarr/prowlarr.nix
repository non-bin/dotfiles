{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../nginx.nix
    ../qbt.nix
  ];

  age.secrets.prowlarr = {
    rekeyFile = ./prowlarr.age;
    generator.script =
      { pkgs, ... }:
      ''key="$(${pkgs.openssl}/bin/openssl rand -hex 16)" && echo "PROWLARR__AUTH__APIKEY=$key" && echo "HOMEPAGE_VAR_PROWLARR_APIKEY=$key"''; # 32 hex chars
  };

  services = {
    prowlarr = {
      enable = true;
      openFirewall = true;
      environmentFiles = [ config.age.secrets.prowlarr.path ];
      dataDir = "/mnt/appdata/prowlarr";
      settings = {
        auth = {
          enable = true;
          method = "Forms";
          required = "DisabledForLocalAddresses";
        };
        server = {
          port = 9696;
          bindAddress = "*";
          urlBase = "/prowlarr/";
          enableSSL = false;
        };
      };
    };

    homepage-dashboard = {
      environmentFiles = [ config.age.secrets.prowlarr.path ];
      services."Media Backend"."Prowlarr" = {
        icon = "prowlarr";
        href = "/prowlarr";
        description = "Indexer Manager";
        server = "local";
        siteMonitor = "http://localhost:9696";
        widget = {
          type = "prowlarr";
          url = "http://localhost:9696";
          key = "{{HOMEPAGE_VAR_PROWLARR_APIKEY}}";
        };
      };
    };

    nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/prowlarr/".proxyPass =
      "http://localhost:9696/prowlarr/";
  };
}
