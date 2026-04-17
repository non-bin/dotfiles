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
    "d /mnt/backups/btrbk/${config.networking.hostName} 0755 root root"
    "f /mnt/backups/btrbk/${config.networking.hostName}/btrbk.log 0755 btrbk btrbk"
  ];

  services.btrbk = {
    sshAccess = [
      {
        key = user.sshPubKey; # FIXME use unique host keys
        roles = [
          "info" # `btrfs subvolume find-new` and `btrfs filesystem usage`
          # "source" # `btrfs subvolume snapshot` and `btrfs send`
          "target" # `btrfs receive` and `mkdir`
          "delete" # `btrfs subvolume delete` FIXME: This is a bit dangerous
          # "snapshot" # `btrfs subvolume snapshot`
          # "send" # `btrfs send`
          "receive" # `btrfs receive`
        ];
      }
    ];
  };
}
