{
  config,
  user,
  ...
}:

{
  users.users.remotebuild = {
    isSystemUser = true;
    group = "remotebuild";
    useDefaultShell = true;

    openssh.authorizedKeys.keys = [ user.sshKeys.skellybones ];
  };

  users.groups.remotebuild = { };

  nix = {
    nrBuildUsers = 64;
    settings = {
      trusted-users = [ "remotebuild" ];

      min-free = 10 * 1024 * 1024; # Garbage collect when free space is under 10MiB
      max-free = 200 * 1024 * 1024; # And stop when it reaches 200MiB

      max-jobs = "auto";
      cores = 0;
    };
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };

  services = {
    nix-serve = {
      enable = true;
      port = 5000;
      openFirewall = true;
      secretKeyFile = "/var/secrets/cache-private-key.pem";
    };
  };
}
