{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = [
    inputs.agenix-rekey.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  age.rekey = {
    masterIdentities = [
      {
        identity = "/home/alice/.ssh/id_rsa";
        pubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlNlKIUyEMf23RugEgJXDMvNY2zDlM3IhONc3/NP4JD9ppoEcUE+JOAl6eVrMox/Q36ZcTHML8BxZfhQoXIGKZWq7ZwFX8pn5SFdNg5OZnY8e/NEEFA/EVOUvP/3L2+Rdkclwz5Rp1UL7Sv5gq98ZzuhxgDZDulDYknd5OGaBHWjrMo1b4Z9li/6aTCs53zl4/38o/TxDGHBiuNDWHtKkdJT47LQ3NVwkh8IP1Id8ZOhoZ0CHimTt0cUg45KLurH2tAU4PxPsaeaSwa6jMjBAY26I/6tadG4ztWlGGqsCYhwCsqCcOH0CRbfKi+qgqHuwa4Sw62fMdhqXl09zPf/VdY3HKdWL0gfyxV3uMTf2OEue6//SiWOJZRQZ9qVpLm5c13+y0A/RXpC3hS8gPvunVkGnj82lxPFrCLx9jYkhvRPLh+eUxwHjUIswFRGgX5vuxEt+0RTGs5jH2CIl5IdviBVWz5GsxcvyqRAuDKu9EkNNawfx1wr//09eBhNMvBw8="; # Specify the public key explicitly
      }
    ];
    storageMode = "local";
    # Choose a directory to store the rekeyed secrets for this host.
    # This cannot be shared with other hosts. Please refer to this path
    # from your flake's root directory and not by a direct path literal like ./secrets
    localStorageDir = ./. + "/secrets/rekeyed/${config.networking.hostName}";
  };

}
