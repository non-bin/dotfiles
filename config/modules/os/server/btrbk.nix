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
    "d /mnt/backups/${config.networking.hostName} 0755 root root"
    "f /mnt/backups/${config.networking.hostName}/btrbk.log 0755 btrbk btrbk"
  ];

  services.btrbk = {
    sshAccess = [
      {
        key = user.sshPubKey;
        roles = [
          "info" # `btrfs subvolume find-new` and `btrfs filesystem usage`
          # "source" # `btrfs subvolume snapshot` and `btrfs send`
          "target" # `btrfs receive` and `mkdir`
          # "delete" # `btrfs subvolume delete`
          # "snapshot" # `btrfs subvolume snapshot`
          # "send" # `btrfs send`
          "receive" # `btrfs receive`
        ];
      }
    ];
  };
}
