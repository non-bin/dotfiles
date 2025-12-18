{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  services.nginx = {
    enable = true;
    enableReload = true; # Reload nginx when configuration file changes (instead of restart)
    clientMaxBodySize = "5G";

    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;

    virtualHosts."${config.networking.fqdnOrHostName}" = {
      default = true;
      extraConfig = lib.strings.concatLines [
        # Proxy websockets
        ''proxy_set_header Upgrade $http_upgrade;''
        ''proxy_set_header Connection $connection_upgrade;''
      ];
    };
  };
}
