{
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/personal.nix
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  age.rekey.hostPubkey = user.sshKeys.skellybones;

  networking.hostName = "skellybones";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.75";
      prefixLength = 24;
    }
  ];

  services = {
    fprintd.enable = true;
    fwupd.enable = true; # run with fwupdmgr update https://github.com/NixOS/nixos-hardware/tree/master/framework
  };

  # Finger print reader
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
}
