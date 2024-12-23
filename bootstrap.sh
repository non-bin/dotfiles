#!/usr/bin/env bash
set -e # Exit on any errors

# Check running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Parse params
DOWNLOAD="NO"
COPY="NO"
INSTALL="NO"
VM="NO"
EVERYTHING="YES" # We only check the others if If EVERYTHING is NO
USERNAME="alice"

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
      EVERYTHING="NO"
      shift # past argument
      ;;
    -e|--everything)
      EVERYTHING="YES"
      shift # past argument
      ;;
    -u|--user)
      USERNAME="$1"
      shift # past argument
      shift # past param
      ;;
    -*|--*)
      echo "Unknown option $1"

      echo "Usage: bootstrap.sh [options] hostname"
      echo
      echo "Options:"
      echo "  -d, --download       Clone the dotfiles to /mnt. Don't do anything else unless other params are given"
      echo "  -c, --copy           Copying hardware config, and nothing else unless specified"
      echo "  -i, --install        Install with the flake as input, nothing else bla bla bla"
      echo "  --vm                 Quickly setup from within a VM. Partition vda, mount dotfiles, and generate hardware config"
      echo "  -e, --everything     Implied unless other switches are passed. Download, copy and install. Equivilent to '-d -c -i'"
      echo "  -u, --user username  Set the username for the user to create. YOU NEED TO UPDATE CONFIGURATION.NIX TO CREATE THE USER"
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
  echo Speeding through setup
  parted /dev/vda -- mklabel gpt
  parted /dev/vda -- mkpart root ext4 512MB -8GB
  parted /dev/vda -- mkpart swap linux-swap -8GB 100%
  parted /dev/vda -- mkpart ESP fat32 1MB 512MB
  parted /dev/vda -- set 3 esp on
  mkfs.ext4 -L nixos /dev/vda1
  mkswap -L swap /dev/vda2
  mkfs.fat -F 32 -n boot /dev/vda3
  mount /dev/disk/by-label/nixos /mnt
  mkdir -p /mnt/boot
  mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
  swapon /dev/vda2
  nixos-generate-config --root /mnt
  mkdir /dotfiles -p
  mount -o ro -t virtiofs dotfiles /dotfiles/ || echo FAILED TO MOUNT DOTFILES
  echo Finished setting up
fi

if [ "$DOWNLOAD" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  echo Downloaing to /mnt/$USERNAME/dotfiles
  git clone https://github.com/non-bin/dotfiles /mnt/$USERNAME/dotfiles
else
  echo Skipping download
fi

if [ ! -f /mnt/etc/nixos/hardware-configuration.nix ] && ( [ "$DOWNLOAD" == "YES" ] || [ "$COPY" == "YES" ] || [ "$EVERYTHING" == "YES" ] ); then
  >&2 echo "hardware-configuration.nix not found! Did you run 'nixos-generate-config --root /mnt' yet?"
  exit 1
fi

if [ "$COPY" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  echo Copying /mnt/etc/nixos/hardware-configuration.nix to /mnt/$USERNAME/dotfiles/hosts/$1/

  cp /mnt/etc/nixos/hardware-configuration.nix /mnt/$USERNAME/dotfiles/hosts/$1/
else
  echo Skipping copy
fi

if [ "$INSTALL" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  echo Building for hostname \"$1\"
  nixos-install --flake /mnt/$USERNAME/dotfiles#$1
  nixos-enter --root /mnt -c 'sudo chown -R $USERNAME:$USERNAME /mnt/$USERNAME/dotfiles && passwd $USERNAME'

  echo "Done! You can reboot now"
else
  echo Skipping install
fi
