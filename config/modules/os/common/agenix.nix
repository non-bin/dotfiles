{
  config,
  lib,
  pkgs,
  inputs,
  user,
  ...
}:

{
  environment.systemPackages = [
    inputs.agenix-rekey.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  age.rekey = {
    masterIdentities = [
      {
        identity = "/home/${user.name}/.ssh/id_rsa";
        pubkey = user.sshPubKey; # Specify the public key explicitly
      }
    ];
    storageMode = "local";
    # Choose a directory to store the rekeyed secrets for this host.
    # This cannot be shared with other hosts. Please refer to this path
    # from your flake's root directory and not by a direct path literal like ./secrets
    localStorageDir = ./. + "/secrets/rekeyed/${config.networking.hostName}";
  };
}
