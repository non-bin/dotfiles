{
  pkgs,
  ...
}:

{
  nix = {
    distributedBuilds = true;

    buildMachines = [
      {
        hostName = "mi.jacka.net.au";
        speedFactor = 2;
        sshUser = "remotebuild";
        sshKey = "/etc/ssh/ssh_host_ed25519_key";
        system = pkgs.stdenv.hostPlatform.system;
        protocol = "ssh-ng";
        supportedFeatures = [
          "nixos-test"
          "big-parallel"
          "kvm"
        ];
      }
    ];
  };
}
