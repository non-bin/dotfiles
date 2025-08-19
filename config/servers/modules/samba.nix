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
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";

          # #"use sendfile" = "yes";
          # #"max protocol" = "smb2";
          # "hosts allow" = "192.168.0. 127.0.0.1 localhost"; # note: localhost is the ipv6 localhost ::1
          # "hosts deny" = "0.0.0.0/0";
          # "guest account" = "nobody";
          # "map to guest" = "bad user";
        };

        "private" = {
          "path" = "/data/private";
          "valid users" = "alice";
          "force user" = "alice";
          "force group" = "alice";
          "public" = "no";
          "writeable" = "yes";
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
        "vault" = {
            "path" = "/data/vault";
            "valid users" = "family";
            "public" = "no";
            "writeable" = "yes";
            "force user" = "alice";
            "fruit:aapl" = "yes";
            "fruit:time machine" = "yes";
            "vfs objects" = "catia fruit streams_xattr";
        };
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
