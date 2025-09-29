{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/personal.nix

    ../../modules/os/server/qbt.nix
  ];

  # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFr10kZ2FZeqfcMnYXIqCW1V5HMPIwb0f4OfJa5mGov2";

  networking.hostName = "skellybones";
  networking.domain = "jacka.net.au";
  networking.interfaces."lo".ipv4.addresses = [
    {
      address = "172.23.24.101";
      prefixLength = 24;
    }
  ];

  # Finger print reader
  services = {
    # beszel = {
    #   agent = {
    #     enable = true;
    #     key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqQ4E9KwbgyCb1pj912x2gzG1x+Eqir+/Yg5PRISjio";
    #   };
    #   hub = {
    #     enable = true;
    #     httpListen = "127.0.0.1:8080";
    #   };
    # };

    fprintd.enable = true;
    fwupd.enable = true; # run with fwupdmgr update https://github.com/NixOS/nixos-hardware/tree/master/framework
  };
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
