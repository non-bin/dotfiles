{ config, lib, pkgs, ... }:

{
  # Set passwords with `sudo smbpasswd -a alice && sudo smbpasswd -a family`
  users.users.family.isNormalUser = true;

  services = {
    samba = {
      enable = true;
      openFirewall = true;

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "security" = "user";

          "use sendfile" = "yes";
          "max protocol" = "smb3";
          # "hosts allow" = "192.168.0. 127.0.0.1 localhost"; # note: localhost is the ipv6 localhost ::1. Defaults to all
          # "hosts deny" = "0.0.0.0/0"; # Defaults to none
          "guest account" = "nobody";
          "map to guest" = "bad user"; # Default to guest if unknown username
        };

        "private" = {
          "path" = "/data/private";
          "browseable" = "yes";
          "valid users" = "alice family kieran";
          "force user" = "alice";
          "force group" = "alice";
          "guest ok" = "no";
          "read only" = "no";
        };

        "media" = {
          "path" = "/data/media";
          "browseable" = "yes";
          "read only" = "yes";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "alice";
          "force group" = "alice";
        };

        "public" = {
          "path" = "/data/public";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "alice";
          "force group" = "alice";
        };

        # Apple Time Machine
        # "vault" = {
        #     "path" = "/data/vault";
        #     "valid users" = "family";
        #     "guest ok" = "no";
        #     "read only" = "yes";
        #     "force user" = "alice";
        #     "fruit:aapl" = "yes";
        #     "fruit:time machine" = "yes";
        #     "vfs objects" = "catia fruit streams_xattr";
        # };
      };
    };

    samba-wsdd = {
      enable = true;
      discovery = true;
      openFirewall = true;
    };

    avahi = {
      enable = true;

      publish.enable = true;
      publish.userServices = true;
      nssmdns4 = true;
    };
  };
}
