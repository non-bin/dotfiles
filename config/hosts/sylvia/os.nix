{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/server.nix
  ];

  networking.hostName = "sylvia";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.89";
      prefixLength = 24;
    }
  ];

  # services.beszel.agent = {
  #   enable = true;
  #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqQ4E9KwbgyCb1pj912x2gzG1x+Eqir+/Yg5PRISjio";
  # };
}
