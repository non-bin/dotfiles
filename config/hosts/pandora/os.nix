{
  user,
  lib,
  inputs,
  ...
}:

{
  imports = [
    "${inputs.nixos-hardware}/common/cpu/intel/kaby-lake"

    ./hardware-configuration.nix
    ../../modules/os/personal/base.nix
    ../../modules/os/common
    ../../modules/os/personal/gnome.nix
  ];

  hardware.intelgpu.enable = true;

  # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  age.rekey.hostPubkey = user.sshKeys.pandora;
  age.secrets.userPass.rekeyFile = lib.mkForce ./userPass.age;

  networking.hostName = "pandora";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.80";
      prefixLength = 24;
    }
  ];
}
