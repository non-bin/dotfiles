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

  age.secrets.sonarr = {
    rekeyFile = ./sonarr.age;
    generator.script =
      { pkgs, ... }:
      ''key="$(${pkgs.openssl}/bin/openssl rand -hex 16)" && echo "SONARR__AUTH__APIKEY=$key" && echo "HOMEPAGE_VAR_SONARR_APIKEY=$key"''; # 32 hex chars
  };

  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
      environmentFiles = [ config.age.secrets.sonarr.path ];
      dataDir = "/mnt/appdata/sonarr";
      settings = {
        auth = {
          enable = true;
          method = "Forms";
          required = "DisabledForLocalAddresses";
        };
        server = {
          port = 8989;
          bindAddress = "*";
          urlBase = "/sonarr/";
          enableSSL = false;
        };
      };
    };

    homepage-dashboard = {
      environmentFiles = [ config.age.secrets.sonarr.path ];
      services."Media Finders"."Sonarr" = {
        icon = "sonarr";
        href = "/sonarr";
        description = "TV Show Finder";
        server = "local";
        siteMonitor = "http://localhost:8989";
        widget = {
          type = "sonarr";
          url = "http://localhost:8989";
          key = "{{HOMEPAGE_VAR_SONARR_APIKEY}}";
        };
      };
    };

    nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/sonarr/".proxyPass =
      "http://localhost:8989/sonarr/";
  };
}
