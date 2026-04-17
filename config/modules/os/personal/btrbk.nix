{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [ ../common/btrbk.nix ];

  # https://www.man7.org/linux/man-pages/man5/tmpfiles.d.5.html
  systemd.tmpfiles.rules = [
    "d /snapshots 0755 root root"
    "f /snapshots/btrbk.log 0755 btrbk btrbk"
  ];

  services.btrbk = {
    instances = {
      "btrbk" = {
        # onCalendar = "hourly"; # `man systemd.time 7`
        settings = {
          # transaction_log = "/snapshots/btrbk.log"; # localtime type status target_url source_url parent_url message
          timestamp_format = "long";
          snapshot_preserve_min = "2d"; # Keep everything for at least 2d
          target_preserve = "168h 30d 26w 12m"; # Keep hourly backups for 1 week, dailies for a month, weeklies for 6 months, and monthlies for 12 months
          snapshot_create = "onchange"; # Don't create snapshots if nothing's changed

          volume."/" = {
            target = "ssh://m.i.jacka.net.au/mnt/backup/btrbk/${config.networking.hostName}/";
            ssh_user = "btrbk";
            subvolume = "/home";
            snapshot_dir = "/snapshots";
          };
        };
      };
    };
  };
}
