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

  custom.btrbkInstance = {
    onCalendar = "hourly"; # `man systemd.time 7`
    snapshot_preserve_min = "2d"; # Keep everything for at least 2d
    target_preserve = "168h 30d 26w 12m"; # Keep hourly backups for 1 week, dailies for a month, weeklies for 6 months, and monthlies for 12 months
    volume."/" = {
      target = "m.i.jacka.net.au";
      subvolume = "/home";
      snapshot_dir = "/snapshots";
    };
  };
}
