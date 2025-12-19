{
  config,
  lib,
  pkgs,
  # options,
  ...
}:

{
  imports = [
    ./homepageOverride.nix # https://github.com/NixOS/nixpkgs/pull/471565

    ./nginx.nix
  ];

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 3000;
    allowedHosts = "*";
    docker = {
      local = {
        socket = "/var/run/docker.sock";
      };
    };
    settings = {
      title = "${config.networking.hostName} - Homepage";
    };
    widgets = [
      {
        resources = {
          label = config.networking.hostName;
          cpu = true;
          memory = true;
        };
      }
    ];
    /*
      Tested on:
      https://jellyfin.jacka.net.au/#:8096 -> http://maureen.i.jacka.net.au:8096
      https://immich.jacka.net.au/#:2283/dhjj -> http://maureen.i.jacka.net.au:2283/dhjj
      https://immich.jacka.net.au/#:2283dhjj -> https://immich.jacka.net.au/#:2283dhjj
      https://aaa.jacka.net.au/#/asd -> http://maureen.i.jacka.net.au/asd
      https://aaa.jacka.net.au/#asd -> https://aaa.jacka.net.au/#asd
      https://immich.jacka.net.au/#http://aeffv.rth -> http://aeffv.rth
      https://immich.jacka.net.au/#http://aeffv.rth/thyj -> http://aeffv.rth/thyj
      https://immich.jacka.net.au/#http://aeffv.rth:123 -> http://aeffv.rth:123
      https://immich.jacka.net.au/#http://aeffv.rth:123/hjyu -> http://aeffv.rth:123/hjyu
      https://immich.jacka.net.au/#https://aeffv.rth -> https://aeffv.rth
      https://immich.jacka.net.au/#https://aeffv.rth/thyj -> https://aeffv.rth/thyj
      https://immich.jacka.net.au/#https://aeffv.rth:123 -> https://aeffv.rth:123
      https://immich.jacka.net.au/#https://aeffv.rth:123/hjyu -> https://aeffv.rth:123/hjyu
      https://something.jacka.net.au -> https://something.jacka.net.au
      /sonarr -> /sonarr
    */
    customJS = ''
      if (window.location.hostname.includes('i.jacka.net.au')) {
        const serviceWidgetsLinks = document.getElementsByClassName('service-title-text');

        for (let i = 0; i < serviceWidgetsLinks.length; i++) {
          serviceWidgetsLinks[i].href = decodeHref(serviceWidgetsLinks[i].href);
        }
      }

      /**
      * @param {string} href Original link href
      * @returns {string} New link url
      */
      function decodeHref(href) {
        const regex = /^(?<external>.*)#((?<full>https?.*)|((?<port>:\d+)?(?<path>\/.*)?))$/.exec(href)?.groups;

        if (regex) {
          if (regex.full) {
            return regex.full;
          } else {
            let suffix = "";
            if (regex.port) {
              suffix += regex.port;
            }
            if (regex.path) {
              suffix += regex.path;
            }

            if (suffix) {
              return window.location.origin + suffix;
            }
          }
        }

        return href;
      }
    '';
  };

  services.nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/".proxyPass =
    "http://localhost:3000/";

  # - Media Finders:
  #     - Lidar:
  #         icon: lidarr
  #         href: /lidarr
  #         description: Music Finder
  #         server: local
  #         container: lidarr
  #         widget:
  #           type: lidarr
  #           url: http://stellnt.i.jacka.net.au:8686
  #           key: 15e146a9f6624f6ebc32a8b2d9d21038

  #     - AudioBookShelf:
  #         icon: audiobookshelf
  #         href: /audiobookshelf
  #         description: Book Library
  #         server: local
  #         container: audiobookshelf
  #         widget:
  #           type: audiobookshelf
  #           url: http://stellnt.i.jacka.net.au:13378
  #           key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1NzFmNTMwMS1lZjA0LTRmYzktODAyOC0wYTZkZGJlNjBlY2QiLCJ1c2VybmFtZSI6ImFsaWNlIiwiaWF0IjoxNzQyMzc2MDU1fQ.qH-RhjQ35eZiBeZz3BgOP1SctXBuilWI3bGeyG8sr24

  #     - LazyLibrarian:
  #         icon: lazylibrarian
  #         href: /lazylib
  #         description: Book Finder
  #         server: local
  #         container: lazylibrarian

  # - Server:
  #     - Beszel:
  #         icon: beszel
  #         href: http://stellnt.i.jacka.net.au:8090
  #         description: Stats
  #         server: local
  #         container: beszel
  #         widget:
  #           type: beszel
  #           url: http://stellnt.i.jacka.net.au:8090
  #           username: jacka.alice@gmail.com # email
  #           password: daqawa12
  #           systemId: stellnt # optional
  #           version: 2 # optional, default is 1
  #     - Dockge:
  #         icon: dockge
  #         href: http://stellnt.i.jacka.net.au:31014/compose/servarr
  #         description: Container Manager
  #         server: local
  #         container: dockge";
}
