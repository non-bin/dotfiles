#!/usr/bin/env bash
set -e # Exit on any errors

# Check running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Parse params
INSTALL="YES"
DOWNLOAD="YES"

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--just-download)
      INSTALL="NO"
      shift # past argument
      ;;
    -i|--just-install)
      DOWNLOAD="NO"
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"

      echo "Usage: bootstrap.sh [options] hostname"
      echo
      echo "Options:"
      echo "  -d, --just-download  Stop after downloading and copying files. Don't run nixos-install"
      echo "  -i, --just-install   Don't download (ie. continue from running with -d)"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if (( $# != 1 )); then
  >&2 echo "Expected 1 parameter, for hostname. Got $#"
  exit
fi

# Actual logic
if [ "$DOWNLOAD" != "YES" ]; then
  echo Skipping download
else
  echo Downloaing
  # Download dotfiles to to /mnt/dotfiles
  # Check ownership

  echo Copying /mnt/etc/nixos/hardware-configuration.nix to /mnt/dotfiles/hosts/$1/
  cp /mnt/etc/nixos/hardware-configuration.nix /mnt/dotfiles/hosts/$1/
fi


if [ "$INSTALL" != "YES" ]; then
  echo Skipping install
else
  echo Building for hostname \"$1\"
  nixos-install --flake /mnt/dotfiles#$1
fi
