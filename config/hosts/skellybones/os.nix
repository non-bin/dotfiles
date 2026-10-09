{
  inputs,
  user,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./hardware-configuration.nix
    ../../modules/os/personal.nix
  ];

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
}
