{
  config,
  lib,
  modulesPath,
  user,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    loader.grub = {
      device = "nodev";
      efiSupport = true;
    };
    swraid = {
      enable = true;
      mdadmConf = ''
        MAILADDR ${user.email}
        ARRAY /dev/md/fast metadata=1.2 UUID=439feb68:0aae4b2b:d4dcc20b:c7a6351e
        ARRAY /dev/md/slow metadata=1.2 UUID=f64f2408:f37fe95a:1b93178f:a0b07c60
      '';
    };
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/mapper/fast-cache";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/fast-cache";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/fast-cache";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=nix"
      "compress=zstd"
    ];
  };

  fileSystems."/mnt/backups" = {
    device = "/dev/mapper/slow-vault";
    fsType = "btrfs";
    options = [
      "subvol=backups"
      "compress=zstd"
    ];
  };

  fileSystems."/mnt/media" = {
    device = "/dev/mapper/slow-vault";
    fsType = "btrfs";
    options = [
      "subvol=media"
      "compress=zstd"
    ];
  };

  fileSystems."/mnt/photos/upload" = { # For immich
    device = "/dev/mapper/slow-vault";
    fsType = "btrfs";
    options = [
      "subvol=photos"
      "compress=zstd"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/mapper/slow-vault";
    fsType = "btrfs";
    options = [
      "subvol=data"
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/12CE-A600";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/aa1563b9-42cf-4b7a-9b4c-1e06c1f030c4"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
