{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../common/btrbk.nix
  ];

  services = {
    btrbk = {
      instances."btrbk" = {
        onCalendar = "*:0/1"; # every minute
        settings = {
          transaction_log = "/snapshots/btrbk.log"; # localtime type status target_url source_url parent_url message
          timestamp_format = "long";
          snapshot_preserve_min = "2d"; # Keep everything for at least 2d
          snapshot_preserve = "168h 30d 26w 12m"; # Keep hourly backups for 1 week, dailies for a month, weeklies for 6 months, and monthlies for 12 months
          snapshot_create = "onchange"; # Don't create snapshots if nothing's changed
          volume."/" = {
            subvolume = "/home";
            snapshot_dir = "/snapshots";
          };
        };
      };
    };
  };
}
