{ config, lib, pkgs, ... }:

let
  capitalize = str:
    if str == "" then ""
    else
      lib.toUpper (lib.substring 0 1 str) + lib.substring 1 (lib.stringLength str - 1) str;
in
{
  imports = [];

  services.nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/" = {
    proxyPass = "http://localhost:3000/";
  };

  services.homepage-dashboard = {
    enable = true;
    listenPort = 3000;
    openFirewall = true;
    allowedHosts = lib.concatStringsSep "," [
      "localhost"
      "127.0.0.1"
      "*.jacka.net.au"
    ];
    widgets = [
      {
        greeting = {
          text_size = "xl";
          text = "${capitalize config.networking.hostName} - Homepage";
        };
      }
    ];
    settings = {
      target = "_self"; # Open links in the same tab
      title = "${capitalize config.networking.hostName} - Homepage";
    };
    docker.local.socket = "/var/run/docker.sock";

    customJS = ''
      const updateHrefs = () => {
        const serviceWidgetsLinks =
          document.getElementsByClassName('service-title-text');

        const local = window.location.hostname.includes('wheresthe');

        for (let i = 0; i < serviceWidgetsLinks.length; i++) {
          const href = serviceWidgetsLinks[i].href;
          const regex = /(?<external>.*)#(?<internal>http.*)/.exec(href)?.groups;

          if (regex) {
            if (local) {
              if (Object.hasOwn(regex, 'internal')) {
                serviceWidgetsLinks[i].href = regex.internal;
              } else
                console.log(
                  JSON.stringify(regex)+' has no internal, leaving unmodified'
                );
            } else {
              if (Object.hasOwn(regex, 'external')) {
                serviceWidgetsLinks[i].href = regex.external;
              } else
                console.log(
                  JSON.stringify(regex)+' has no external, leaving unmodified'
                );
            }
          } else
            console.error(
              'Regex failed for '+href,
              JSON.stringify(regex),
              serviceWidgetsLinks[i]
            );

          console.log(serviceWidgetsLinks[i].href);
        }
      };

      updateHrefs();
    '';
  };
}
