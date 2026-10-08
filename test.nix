let
  lib = import <nixpkgs/lib>;
  sshKeys = {
    personal = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlNlKIUyEMf23RugEgJXDMvNY2zDlM3IhONc3/NP4JD9ppoEcUE+JOAl6eVrMox/Q36ZcTHML8BxZfhQoXIGKZWq7ZwFX8pn5SFdNg5OZnY8e/NEEFA/EVOUvP/3L2+Rdkclwz5Rp1UL7Sv5gq98ZzuhxgDZDulDYknd5OGaBHWjrMo1b4Z9li/6aTCs53zl4/38o/TxDGHBiuNDWHtKkdJT47LQ3NVwkh8IP1Id8ZOhoZ0CHimTt0cUg45KLurH2tAU4PxPsaeaSwa6jMjBAY26I/6tadG4ztWlGGqsCYhwCsqCcOH0CRbfKi+qgqHuwa4Sw62fMdhqXl09zPf/VdY3HKdWL0gfyxV3uMTf2OEue6//SiWOJZRQZ9qVpLm5c13+y0A/RXpC3hS8gPvunVkGnj82lxPFrCLx9jYkhvRPLh+eUxwHjUIswFRGgX5vuxEt+0RTGs5jH2CIl5IdviBVWz5GsxcvyqRAuDKu9EkNNawfx1wr//09eBhNMvBw8=";

    # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
    maureen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDz2Ia+hmbEQ0kuXxIEbFv6zxM+zXVXePq+jZxLrZiE1";
    skellybones = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFr10kZ2FZeqfcMnYXIqCW1V5HMPIwb0f4OfJa5mGov2";
    stella = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn8uDmv1Bo4GZw2hdwoKvCvWD1k7Rag8W89c85OjZpw";
    pandora = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMDRtk3JliTktdSozZu9Om+vmRlpAHU9uE1AidyQEPHi";
  };
  hosts = {
    maureen = [
      "mi.jacka.net.au"
      "ssh-m.jacka.net.au"
    ];
    stella = [
      "si.jacka.net.au"
      "ssh-s.jacka.net.au"
    ];
  };
in
{
  knownHosts =
    lib.mapAttrs (name: hostNames: {
      inherit hostNames;
      publicKey = sshKeys.${name};
    }) hosts;
}
