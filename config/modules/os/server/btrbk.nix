{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [ ../common/btrbk.nix ];

  options.custom.btrbkSSHKeys = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    description = ''
      List of public keys for backup clients to access the backup server.

      This is used to generate the `sshAccess` configuration for the `btrbk` service.
    '';
    default = [ ];
  };

  # https://www.man7.org/linux/man-pages/man5/tmpfiles.d.5.html
  config.systemd.tmpfiles.rules = [
    "d /mnt/backups/btrbk/${config.networking.hostName} 0755 root root"
    "f /mnt/backups/btrbk/${config.networking.hostName}/btrbk.log 0755 btrbk btrbk"
  ];

  config.services.btrbk = {
    sshAccess = lib.mkIf (config.custom.btrbkSSHKeys != [ ]) [
      (lib.map (key: {
        key = key;
        roles = [
          "info" # `btrfs subvolume find-new` and `btrfs filesystem usage`
          # "source" # `btrfs subvolume snapshot` and `btrfs send`
          "target" # `btrfs receive` and `mkdir`
          "delete" # `btrfs subvolume delete` FIXME: This is a bit dangerous
          # "snapshot" # `btrfs subvolume snapshot`
          # "send" # `btrfs send`
          "receive" # `btrfs receive`
        ];
      }) config.custom.btrbkSSHKeys)
    ];
  };
}
