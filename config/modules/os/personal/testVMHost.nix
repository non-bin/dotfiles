{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = {
    bridgeName = "br0";
    externalInterface = "wlp1s0";
  };
in
{
  imports = [ ];

  networking.nat = {
    enable = true;
    internalInterfaces = [ cfg.bridgeName ];
    externalInterface = cfg.externalInterface;
  };

  # libvirt uses 192.168.122.0
  networking.bridges."${cfg.bridgeName}".interfaces = [ ];
  networking.interfaces."${cfg.bridgeName}" = {
    ipv4.addresses = [
      {
        address = "192.168.123.1";
        prefixLength = 24;
      }
    ];
  };

  networking.dhcpcd = {
    enable = true;
    # interfaces = [ cfg.bridgeName ];
    extraConfig = ''
      option routers 192.168.123.1;
      option broadcast-address 192.168.123.255;
      option subnet-mask 255.255.255.0;
      option domain-name-servers 37.205.9.100, 37.205.10.88, 1.1.1.1;
      subnet 192.168.123.0 netmask 255.255.255.0 {
        range 192.168.123.100 192.168.123.200;
      }
    '';
  };

  # NixOS guests obtain address, routes, and DNS from router advertisements.
  # So there's no need to run DHCP if you're OK with SLAAC addresses.
  /*
    services.dhcpd6 = mkIf v6Enabled {
      enable = true;
      interfaces = [ cfg.bridgeName ];
      extraConfig = ''
        ${optionalString (cfg.ipv6.nameServers != []) ''
          option dhcp6.name-servers ${builtins.concatStringsSep ", " cfg.ipv6.nameServers};
        ''}
        ${optionalString cfg.infiniteLeaseTime  ''
        default-lease-time -1;
        max-lease-time -1;
        ''}
        subnet6 ${cfg.ipv6.network} {
        }
      '';
    };
  */
}
