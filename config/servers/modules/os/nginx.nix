{ config, lib, pkgs, ... }:

{
  imports = [];

  services.nginx = {
    enable = true;
    enableReload = true; # Reload nginx when configuration file changes (instead of restart)
    clientMaxBodySize = "5G";
    virtualHosts."${config.networking.fqdnOrHostName}" = {
      extraConfig = lib.strings.concatLines [
        # Set headers
        ''proxy_set_header Host              $host;''
        ''proxy_set_header X-Real-IP         $remote_addr;''
        ''proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;''
        ''proxy_set_header X-Forwarded-Host  $host;''
        ''proxy_set_header X-Forwarded-Proto $scheme;''
        ''auth_basic off;''

        # enable websockets: http://nginx.org/en/docs/http/websocket.html
        ''proxy_http_version 1.1;''
        ''proxy_set_header   Upgrade    $http_upgrade;''
        ''proxy_set_header   Connection "upgrade";''
        ''proxy_redirect     off;''
      ];
    };
  };
}
