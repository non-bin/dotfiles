#!/usr/bin/env bash
set -e # Exit on any errors

# Colour codes. Use with `echo -e "${GREEN}I ${RED}love${NC} Stack Overflow"``
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# Check running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run as root${NC}"
  exit
fi

# Parse params
DOWNLOAD="NO"
COPY="NO"
INSTALL="NO"
VM="NO"
EVERYTHING="YES" # We only check the others if If EVERYTHING is NO
USERNAME="alice"
UPGRADE="NO"
DISK="/dev/vda"

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--download)
      DOWNLOAD="YES"
      EVERYTHING="NO"
      shift # past argument
      ;;
    -c|--copy)
      COPY="YES"
      EVERYTHING="NO"
      shift # past argument
      ;;
    -i|--install)
      INSTALL="YES"
      EVERYTHING="NO"
      shift # past argument
      ;;
    --vm)
      VM="YES"
      shift # past argument
      ;;
    -e|--everything)
      EVERYTHING="YES"
      shift # past argument
      ;;
    -n|--nothing)
      EVERYTHING="NO"
      shift # past argument
      ;;
    --user)
      USERNAME="$1"
      shift # past argument
      shift # past param
      ;;
    --disk)
      DISK="$1"
      shift # past argument
      shift # past param
      ;;
    -u|--upgrade)
      UPGRADE="YES"
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"

      echo "Usage: bootstrap.sh [options] hostname"
      echo
      echo "Options:"
      echo "  -d, --download    Clone the dotfiles to /mnt. Implies -n"
      echo "  -u, --upgrade     Update flake.lock to the latest versions before installing"
      echo "  -c, --copy        Copying hardware config. Implies -n"
      echo "  -i, --install     Install with the flake as input. Implies -n"
      echo "  -e, --everything  Implied unless other switches are passed. Download, copy and install. Equivilent to '-d -c -i'"
      echo "  -n, --nothing     Require explicitly enabling any steps you want"
      echo "  --vm              Quickly setup from within a VM. Partition vda, generate hardware config, and mount virtiofs dotfiles if available"
      echo "  --disk path       Use with --vm. Path to the block device to install onto, defaults to /dev/vda"
      echo "  --user username   Set the username for the user to create. YOU NEED TO UPDATE CONFIGURATION.NIX TO CREATE THE USER"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# No hostname   and (we're doing everything     or     installing          or    copying )
if (( $# != 1 )) && ([ "$EVERYTHING" == "YES" ] || [ "$INSTALL" == "YES" ] || [ "$COPY" == "YES" ]); then
  >&2 echo "Expected 1 parameter, for hostname. Got $#"
  exit 1
fi

# Actual logic
if [ "$VM" == "YES" ]; then
  echo -e "${GREEN}Speeding through setup${NC}"
  parted $DISK -- mklabel gpt
  parted $DISK -- mkpart root ext4 512MB -8GB
  parted $DISK -- mkpart swap linux-swap -8GB 100%
  parted $DISK -- mkpart ESP fat32 1MB 512MB
  parted $DISK -- set 3 esp on
  mkfs.ext4 -L nixos $DISK1
  mkswap -L swap $DISK2
  mkfs.fat -F 32 -n boot $DISK3
  mount /dev/disk/by-label/nixos /mnt
  mkdir -p /mnt/boot
  mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
  swapon $DISK2
  nixos-generate-config --root /mnt
  mkdir /dotfiles -p
  mount -o ro -t virtiofs dotfiles /dotfiles/ || echo -e "${RED}FAILED TO MOUNT LOCAL DOTFILES${NC}"
  echo -e "${GREEN}Finished setting up${NC}"
fi

if [ "$DOWNLOAD" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  echo -e "${GREEN}Downloading to /mnt/home/$USERNAME/dotfiles${NC}"
  git clone https://github.com/non-bin/dotfiles /mnt/home/$USERNAME/dotfiles
fi

if [ "$UPGRADE" == "YES" ]; then
  echo -e "${GREEN}Upgrading flake.lock${NC}"
  nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update --flake /mnt/home/$USERNAME/dotfiles
fi

if [ ! -f /mnt/etc/nixos/hardware-configuration.nix ] && ( [ "$DOWNLOAD" == "YES" ] || [ "$COPY" == "YES" ] || [ "$EVERYTHING" == "YES" ] ); then
  >&2 echo -e "${RED}hardware-configuration.nix not found! Did you run 'nixos-generate-config --root /mnt' yet?${NC}"
  exit 1
fi

if [ "$COPY" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  echo -e "${GREEN}Copying /mnt/etc/nixos/hardware-configuration.nix to /mnt/home/$USERNAME/dotfiles/hosts/$1/${NC}"
  cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/$USERNAME/dotfiles/hosts/$1/
fi

if [ "$INSTALL" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  echo -e "${GREEN}Building for hostname \"$1\"${NC}"
  nixos-install --flake /mnt/home/$USERNAME/dotfiles#$1
  echo "Setting password for $USERNAME"
  nixos-enter --root /mnt -c "chown -R $USERNAME:$USERNAME /home/$USERNAME/dotfiles && passwd $USERNAME"

  echo -e "${GREEN}Done! You can reboot now${NC}"
fi
