{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/vg0-btr_pool";
    fsType = "btrfs";
    options = [ "subvol=NixOS" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/vg0-btr_pool";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/vg0-btr_pool";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=nix"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9E37-91B8";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/swap" = {
    device = "/dev/mapper/vg0-btr_pool";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
