{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  # services = {
  #   btrbk = {
  #     # Example in config/personal/modules/os/btrbk.nix
  #   };
  # };

  # https://www.man7.org/linux/man-pages/man5/tmpfiles.d.5.html
  systemd.tmpfiles.rules = [
    "d /snapshots 0755 root root"
    "f /snapshots/btrbk.log 0755 btrbk btrbk"
  ];
}
