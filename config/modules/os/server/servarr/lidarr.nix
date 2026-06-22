{
  config,
  ...
}:

{
  imports = [
    ./prowlarr.nix
    ../qbt.nix

    ../nginx.nix
  ];

  age.secrets.lidarr = {
    rekeyFile = ./lidarr.age;
    generator.script =
      { pkgs, ... }:
      ''key="$(${pkgs.openssl}/bin/openssl rand -hex 16)" && echo "LIDARR__AUTH__APIKEY=$key" && echo "HOMEPAGE_VAR_LIDARR_APIKEY=$key"''; # 32 hex chars
  };

  services = {
    lidarr = {
      enable = true;
      openFirewall = true;
      environmentFiles = [ config.age.secrets.lidarr.path ];
      dataDir = "/mnt/appdata/lidarr";
      settings = {
        auth = {
          enable = true;
          method = "Forms";
          required = "DisabledForLocalAddresses";
        };
        server = {
          port = 8686;
          bindAddress = "*";
          urlBase = "/lidarr/";
          enableSSL = false;
        };
      };
    };

    homepage-dashboard = {
      environmentFiles = [ config.age.secrets.lidarr.path ];
      services."Media Finders"."lidarr" = {
        icon = "lidarr";
        href = "/lidarr";
        description = "Music Finder";
        server = "local";
        siteMonitor = "http://localhost:8686";
        widget = {
          type = "lidarr";
          url = "http://localhost:8686";
          key = "{{HOMEPAGE_VAR_LIDARR_APIKEY}}";
        };
      };
    };

    nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/lidarr/".proxyPass =
      "http://localhost:8686/lidarr/";
  };
}
