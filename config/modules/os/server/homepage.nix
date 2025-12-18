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

  #     customJS = "const updateHrefs = () => {
  #   const serviceWidgetsLinks =
  #     document.getElementsByClassName('service-title-text');

  #   const local = window.location.hostname.includes('wheresthe');

  #   for (let i = 0; i < serviceWidgetsLinks.length; i++) {
  #     const href = serviceWidgetsLinks[i].href;
  #     const regex = /(?<external>.*)#(?<internal>http.*)/.exec(href)?.groups;

  #     if (regex) {
  #       if (local) {
  #         if (Object.hasOwn(regex, 'internal')) {
  #           serviceWidgetsLinks[i].href = regex.internal;
  #         } else
  #           console.log(
  #             `\${JSON.stringify (regex)} has no internal, leaving unmodified`
  #           );
  #       } else {
  #         if (Object.hasOwn(regex, 'external')) {
  #           serviceWidgetsLinks[i].href = regex.external;
  #         } else
  #           console.log(
  #             `\${JSON.stringify (regex)} has no external, leaving unmodified`
  #           );
  #       }
  #     } else
  #       console.error(
  #         `Regex failed for \${href}`,
  #         JSON.stringify(regex),
  #         serviceWidgetsLinks[i]
  #       );

  #     console.log(serviceWidgetsLinks[i].href);
  #   }
  # };

  # updateHrefs();";
}
