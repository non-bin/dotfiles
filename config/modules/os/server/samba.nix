{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  age.secrets.sambaPassword.rekeyFile = ./sambaPassword.age;
  # The password is repeated twice with newline characters as smbpasswd requires a password
  # confirmation even in non-interactive mode where input is piped in through stdin.
  system.activationScripts.init_smbpasswd.text = ''${pkgs.coreutils}/bin/printf "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.sambaPassword.path})\n$(${pkgs.coreutils}/bin/cat ${config.age.secrets.sambaPassword.path})\n" | ${pkgs.samba}/bin/smbpasswd -sa ${user.name}'';

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

        # "private" = {
        #   "path" = "/data/private";
        #   "browseable" = "yes";
        #   "valid users" = "alice family kieran";
        #   "force user" = user.name;
        #   "force group" = user.name;
        #   "guest ok" = "no";
        #   "read only" = "no";
        # };

        # "media" = {
        #   "path" = "/data/media";
        #   "browseable" = "yes";
        #   "read only" = "yes";
        #   "guest ok" = "yes";
        #   "write list" = user.name;
        #   "create mask" = "0644";
        #   "directory mask" = "0755";
        #   "force user" = user.name;
        #   "force group" = user.name;
        # };

        # "public" = {
        #   "path" = "/data/public";
        #   "browseable" = "yes";
        #   "read only" = "no";
        #   "guest ok" = "yes";
        #   "create mask" = "0644";
        #   "directory mask" = "0755";
        #   "force user" = user.name;
        #   "force group" = user.name;
        # };

        # Apple Time Machine
        # "vault" = {
        #     "path" = "/data/vault";
        #     "valid users" = "family";
        #     "guest ok" = "no";
        #     "read only" = "yes";
        #     "force user" = user.name;
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
