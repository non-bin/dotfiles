{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  # # Example
  # services.btrbk.instances."btrbk" = {
  #   onCalendar = "*:0/1"; # every minute
  #   settings = {
  #     transaction_log = "/snapshots/btrbk.log"; # localtime type status target_url source_url parent_url message
  #     timestamp_format = "long";
  #     snapshot_preserve_min = "2d"; # Keep everything for at least 2d
  #     snapshot_preserve = "168h 30d 26w 12m"; # Keep hourly backups for 1 week, dailies for a month, weeklies for 6 months, and monthlies for 12 months
  #     snapshot_create = "onchange"; # Don't create snapshots if nothing's changed
  #     volume."/" = {
  #       subvolume = "/home";
  #       snapshot_dir = "/snapshots";
  #     };
  #   };
  # };

  options.custom = {
    btrbkInstance = lib.mkOption {
      type =
        with lib;
        with lib.types;
        submodule {
          options = {
            onCalendar = mkOption {
              type = nullOr str;
              default = "hourly";
            };
            snapshot_preserve_min = mkOption {
              type = nullOr str;
              default = "2d";
            };
            target_preserve = mkOption {
              type = nullOr str;
              default = "168h 30d 26w 12m";
            };
            volume = mkOption {
              type = attrsOf (submodule {
                options = {
                  target = mkOption {
                    type = str;
                  };
                  subvolume = mkOption {
                    type = str;
                  };
                  snapshot_dir = mkOption {
                    type = str;
                  };
                };
              });
            };
          };
        };

      description = ''
        Configuration for a single `btrbk` instance.

        This is used to generate the `instances` configuration for the `btrbk` service.
      '';
      example = {
        onCalendar = "hourly";
        snapshot_preserve_min = "2d";
        target_preserve = "168h 30d 26w 12m";
        volume."/" = {
          target = "m.i.jacka.net.au";
          subvolume = "/home";
          snapshot_dir = "/snapshots";
        };
      };
    };
  };

  config.services.btrbk = {
    instances = {
      "btrbk" = lib.mkIf (config.custom.btrbkInstance != { }) {
        onCalendar = config.custom.btrbkInstance.onCalendar;
        settings = {
          # transaction_log = "/snapshots/btrbk.log"; # localtime type status target_url source_url parent_url message
          lockfile = "/run/lock/btrbk.lock";
          timestamp_format = "long";
          snapshot_preserve_min = config.custom.btrbkInstance.snapshot_preserve_min;
          target_preserve = config.custom.btrbkInstance.target_preserve;
          snapshot_create = "onchange"; # Don't create snapshots if nothing's changed
          stream_compress = "zstd";

          # Update target to include the path
          # volume = lib.genAttrs config.custom.btrbkInstance.volume (
          #   volumeName: volumeConfig: {
          #     target = "ssh://${volumeConfig.target}/mnt/backups/btrbk/${config.networking.hostName}/"; # FIXME must exist on target
          #     subvolume = volumeConfig.subvolume;
          #     snapshot_dir = volumeConfig.snapshot_dir;
          #   }
          # );
        };
      };
    };
  };
}
