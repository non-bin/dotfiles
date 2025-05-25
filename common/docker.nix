# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
      # daemon.settings = {
      #   userland-proxy = false;
      #   experimental = true;
      #   metrics-addr = "0.0.0.0:9323";
      #   ipv6 = true;
      #   fixed-cidr-v6 = "fd00::/80";
      # };
    };

    # oci-containers = {
    #   # backend = "docker"; # Defaults to podman
    #   containers = {
    #     dockger = {
    #       image = "louislam/dockge:1";
    #       ports = ["127.0.0.1:5001:5001"];
    #       volumes = [
    #         "/var/run/docker.sock:/var/run/docker.sock"
    #         "./data:/app/data"

    #         # If you want to use private registries, you need to share the auth file with Dockge:
    #         # "/root/.docker/:/root/.docker"

    #         # Stacks Directory
    #         # ⚠️ READ IT CAREFULLY. If you did it wrong, your data could end up writing into a WRONG PATH.
    #         # ⚠️ 1. FULL path only. No relative path (MUST)
    #         # ⚠️ 2. Left Stacks Path === Right Stacks Path (MUST)
    #         "/opt/stacks:/opt/stacks"
    #       ];
    #       environment = {
    #         DOCKGE_STACKS_DIR="/opt/stacks";
    #       };
    #     };
    #   };
    # };
  };

  # Remember to add users to the docker group

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
