# Alice's Dot Files

## Bootstraping

Follow [this guide in the manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual), up to and including `nixos-generate-config`  
Once it instructs you to edit `configuration.nix`, run

```bash
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME

sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME --help # For usage

# Or if you'd like to edit the config before installing
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME -d -c -v # To download, copy the hardware config, and update stateVersion
# Edit away
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME -i # To finish the install

# Or to disable copying hardware config
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME -d -v -i

# Or setup just the package and home managers (for non NixOS hosts)
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME -h
# Or if you don't habe curl
sudo bash -c "$(wget -qO- jacka.net.au/dot)" -- HOSTNAME -h

# Or to quickly setup a VM
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME --vm
# And use a custom substituter, like `nix run github:edolstra/nix-serve` running on the host
sudo bash -c "$(curl -L jacka.net.au/dot)" -- HOSTNAME --vm --sub http://hostip:5000
```

## Development

### Formatting

To format the repo use `treefmt`, which runs the official nixfmt command on every file it finds, Or in VSCode use the nix-ide extension which also uses nixfmt

To format shell scripts use `shfmt -w -i 2 -ci -s ./`. TODO add to treefmt

### Secrets

```bash
# To create or edit a secret
agenix edit ./path/to/secret.age

# Then after adding a new host key, or creating or editing a secret
agenix rekey

# And to view all secrets
agenix view
```

### TODO

- Secret management
- Check bootstrap
- Factor out common flake terms
- GhostyTerm
- hardware.cpu.amd.updateMicrocode
- check <https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/> works
- wl-clip-persist
- hyprlock fprintd feedback

### Resources

[NixOS Package Search](https://search.nixos.org/packages?channel=unstable)
[Nüschtos Options Search](https://search.n%C3%BCschtos.de)
[JSON to Nix](https://json-to-nix.pages.dev/)

### BIOS

```nix
{
  boot.loader = {
  grub = {
    efiSupport = false;
    device = "nodev";
  };

  efi.canTouchEfiVariables = false;
  };
}
```

## TODO

- KMonad

### Server Setup

#### Stella

10.124.0.3

2x 2TB HDDs
1x 120GB SSD (Not needed?)

#### Data Transfer

1. Setup stella with the 4tb
2. move everything from the 2x2tb hdds and take them to maureen
3. backup stellnt to stella
4. split the 250 into 2x 120 partitions
5. raid 0 the 4 120s and the 2 new partitions
6. partition the 500 as a regular boot drive (512m esp, 499g btrfs, subvolumes) and install
7. create a subvolume on the boot part and copy half of stellnt to it
8. copy the other half of stellnt to the ssd raid
9. move the 2x 2tb drives from stellnt
10. raid 6 the 5x 2tb drives (2 disk failures, or the 4tb) 6tb usable
11. copy everything to the new hdd raid
12. move the ssd from stellnt
13. expand the SSD raid0 to include the new disk
14. setup btrbk to backup the ssh to the hdd

HDD: Raid6 (2 disk failures) 6tb usable
SSH: Raid0 (no failures, backup to HDDs)

| Size | Type | From    | To      |
| ---- | ---- | ------- | ------- |
| 2000 | HDD  | stella  | maureen |
| 2000 | HDD  | stella  | maureen |
| 2000 | HDD  | maureen | maureen |
| 2000 | HDD  | stellnt | maureen |
| 2000 | HDD  | stellnt | maureen |
|      |      |         |         |
| 120  | SSD  | stella  | maureen |
| 120  | SSD  | stellnt | maureen |
| 120  | SSD  | spare   | maureen |
| 120  | SSD  | spare   | maureen |
| 120  | SSD  | spare   | maureen |
| 120  | SSD  | spare   | maureen |
|      |      |         |         |
| 4000 | HDD  | spare   | stella  |
|      |      |         |         |
| 1000 | HDDM | spare   | sylvia  |
|      |      |         |         |
| 250  | SSD  | spare   |         |
| 1000 | HDDM | spare   |         |

#### Install Commands

```shell
sudo -i

# Setup disk 1
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 1 esp on
parted /dev/vda -- mkpart pool1 512MB 100%

# Format boot part
mkfs.fat -F 32 -n BOOT /dev/vda1

# Set up device pool
pvcreate /dev/vda2
pvcreate /dev/vdb
vgcreate vg0 /dev/vda2 /dev/vdb
lvcreate -L 8G -n swap vg0
lvcreate -l +100%FREE -n btr vg0

# Set up btrfs subvolumes
mkfs.btrfs /dev/vg0/btr
mkdir -p /mnt
mount /dev/vg0/btr /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/data
umount /mnt

# Mount the filesystems
mount -o compress=zstd,subvol=root /dev/sdb2 /mnt
mkdir /mnt/{home,nix,boot,data}
mount -o compress=zstd,subvol=home /dev/sdb2 /mnt/home
mount -o compress=zstd,subvol=data /dev/sdb2 /mnt/data
mount -o compress=zstd,noatime,subvol=nix /dev/sdb2 /mnt/nix
mount /dev/vda1 /mnt/boot
mkswap -L swap /dev/vg0/swap
swapon /dev/vg0/swap
```
