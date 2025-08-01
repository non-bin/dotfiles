#!/usr/bin/env bash
set -e # Exit on any errors

# Colour codes. Use with `echo -e "${GREEN}I ${RED}love${NC} Stack Overflow"``
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Parse params
DOWNLOAD="NO"
COPY="NO"
UPDATE_STATE_VERSION="NO"
INSTALL="NO"
VM="NO"
EVERYTHING="YES" # We only check the others if If EVERYTHING is NO
USERNAME="alice"
UPGRADE="NO"
HOME_MANAGER="NO"
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
    -v|--version)
      UPDATE_STATE_VERSION="YES"
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
    -h|--homeman)
      HOME_MANAGER="YES"
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"

      echo "Usage: bootstrap.sh [options] hostname"
      echo
      echo "Options:"
      echo "  -d, --download    Clone the dotfiles to /mnt. Implies -n"
      echo "  -u, --upgrade     Update flake.lock to the latest versions before installing"
      echo "  -c, --copy        Copy hardware config. Implies -n"
      echo "  -i, --install     Install with the flake as input. Implies -n"
      echo "  -v, --version     Update stateVersion. Implies -n"
      echo "  -e, --everything  Implied unless other switches are passed. Download, copy and install. Equivilent to '-d -c -i'"
      echo "  -n, --nothing     Require explicitly enabling any steps you want"
      echo "  -h, --homeman     Install using just the package manager and Home Manager, on a non NixOS machine"
      echo "  --vm              Quickly setup from within a VM. Partition vda, generate hardware config, and mount virtiofs dotfiles"
      echo "  --disk path       Use with --vm. Path to the block device to install onto, defaults to /dev/vda"
      echo "  --user username   Set the username for the user to create. YOU NEED TO UPDATE CONFIGURATION.NIX TO CREATE THE USER"
      echo
      echo "Options must be specified with separate tacs (these: '-'). For example use '-u -c -P' not '-ucP"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

# Check running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run as root${NC}"
  exit
fi

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters
HOME_PATH="/mnt/home/$USERNAME/"

if ([ "$VM" == "YES" ] || [ "$INSTALL" == "YES" ] || [ "$COPY" == "YES" ] || [ "$UPDATE_STATE_VERSION" == "YES" ]) && [ "$HOME_MANAGER" == "YES" ]; then
  echo -e "${RED}The homeman option cannot be used with vm, copy, or install${NC}"
  exit 1
fi

# No hostname   and (we're doing everything     or     installing          or    copying )
if (( $# != 1 )) && ([ "$EVERYTHING" == "YES" ] || [ "$INSTALL" == "YES" ] || [ "$COPY" == "YES" ] || [ "$HOME_MANAGER" == "YES" ]); then
  echo -e "${RED}Expected 1 parameter, for hostname. Got $#${NC}"
  exit 1
fi

# Actual logic
if [ "$VM" == "YES" ]; then
  if [ ! -d /sys/firmware/efi/efivars ]; then
    echo -e "${RED}Not in EFI mode, VM setup can't do that yet${NC}"
    exit 1
  fi

  echo -e "${GREEN}Speeding through setup${NC}"
  umount -lR /mnt || true
  sync
  lvremove -f vg0/btr_pool || true
  vgremove -f vg0 || true
  pvremove -f ${DISK}1 || true
  swapoff ${DISK}2 || true

  parted ${DISK} -s -- mklabel gpt
  parted ${DISK} -s -- mkpart root 512MB -1GB
  parted ${DISK} -s -- mkpart swap linux-swap -1GB 100%
  parted ${DISK} -s -- mkpart ESP fat32 1MB 512MB
  parted ${DISK} -s -- set 3 esp on

  pvcreate ${DISK}1
  vgcreate vg0 ${DISK}1
  lvcreate -y -l +100%FREE -n btr_pool vg0
  mkfs.btrfs /dev/vg0/btr_pool
  mount /dev/vg0/btr_pool /mnt
  btrfs subvolume create /mnt/NixOS /mnt/nix /mnt/home
  umount /mnt

  mount -o subvol=NixOS /dev/vg0/btr_pool /mnt
  mkdir /mnt/{home,nix,boot}
  mount -o subvol=home /dev/vg0/btr_pool /mnt/home
  mount -o noatime,subvol=nix /dev/vg0/btr_pool /mnt/nix

  mkfs.fat -F 32 -n boot ${DISK}3
  mount ${DISK}3 /mnt/boot

  mkswap -L swap ${DISK}2
  swapon ${DISK}2

  nixos-generate-config --root /mnt
  mkdir /dotfiles -p
  mount -o ro -t virtiofs dotfiles /dotfiles/ || echo -e "${RED}FAILED TO MOUNT LOCAL DOTFILES${NC}"
  echo -e "${GREEN}Finished vm setup${NC}"
fi

if [ "$HOME_MANAGER" == "YES" ]; then
  HOME_PATH="/home/$USERNAME/"
  REQUIRED_PACKAGES="curl tar git"
  if apt-get -v > /dev/null; then
    echo -e "${GREEN}Installing required packages with apt-get${NC}"
    apt-get update
    apt-get -y install $REQUIRED_PACKAGES
  else
    echo -e "${RED}apt-get not present, make sure the following are installed: $REQUIRED_PACKAGES${NC}"
  fi
fi

if [ "$DOWNLOAD" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
  if [ -f /dotfiles/flake.nix ]; then
    echo -e "${GREEN}Copying /dotfiles/ to ${HOME_PATH}dotfiles${NC}"
    mkdir ${HOME_PATH}
    cp -r /dotfiles ${HOME_PATH}dotfiles
  else
    echo -e "${GREEN}Downloading to ${HOME_PATH}dotfiles${NC}"
    if [ "$HOME_MANAGER" == "YES" ]; then
      sudo -u $SUDO_USER git clone https://github.com/non-bin/dotfiles ${HOME_PATH}dotfiles
    else
      git clone https://github.com/non-bin/dotfiles ${HOME_PATH}dotfiles
    fi
  fi
fi

if [ "$UPGRADE" == "YES" ]; then
  echo -e "${GREEN}Upgrading flake.lock${NC}"
  nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update --flake ${HOME_PATH}dotfiles
fi

if [ "$HOME_MANAGER" != "YES" ]; then
  # Check hardwawre config exists if needed
  if [ ! -f /mnt/etc/nixos/hardware-configuration.nix ] && ( [ "$COPY" == "YES" ] || [ "$EVERYTHING" == "YES" ] ); then
    echo -e "${RED}hardware-configuration.nix not found! Did you run 'nixos-generate-config --root /mnt' yet?${NC}"
    exit 1
  fi

  CONFIG_PATH=$(find ${HOME_PATH}dotfiles/config/{servers,personal} -maxdepth 1 -mindepth 1 -iname $1)/
  if [ "$COPY" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
    echo -e "${GREEN}Copying /mnt/etc/nixos/hardware-configuration.nix to ${CONFIG_PATH}${NC}"
    cp /mnt/etc/nixos/hardware-configuration.nix $CONFIG_PATH --backup=t # Make numbered backups
    (cd $CONFIG_PATH && git add $CONFIG_PATH/hardware-configuration.nix)
  fi

  if [ "$UPDATE_STATE_VERSION" == "YES" ] || [ "$EVERYTHING" == "YES" ]; then
    # NEW_VERSION=$(nix-instantiate --eval --expr "builtins.substring 0 5 ((import <nixpkgs> {}).lib.version)") # Latest version from upstream `nixpkgs.url` ("25.11pre-git" or "25.11pre826760.9b008d603929")
    # NEW_VERSION=\"$(nixos-version | sed 's/\([0-9]*\.[0-9]*\).*/\1/')\" # Current running os version (25.11.20250630.3016b4b (Xantusia))
    NEW_VERSION=$(nix-instantiate --eval --expr "builtins.substring 0 5 ((import <nixos> {}).lib.version)") # From active config ("24.11.711150.314e12ba369c")

    echo -e "${GREEN}Updating stateVersion to ${NEW_VERSION}${NC}"

    sed -i "s/\\(stateVersion\\W*=\\W*\\)\"[0-9]*.[0-9]*\"/\\1$NEW_VERSION/g" "${CONFIG_PATH}configuration.nix"
    sed -i "s/\\(stateVersion\\W*=\\W*\\)\"[0-9]*.[0-9]*\"/\\1$NEW_VERSION/g" "${CONFIG_PATH}home.nix"
  fi
fi

if [ "$HOME_MANAGER" == "YES" ]; then
  echo -e "${GREEN}Installing "Nix: the package manager"${NC}"
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon --yes

  # Run as unprivileged user
  sudo -i -u $SUDO_USER bash << EOF
    . '/etc/bash.bashrc'
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' # Should be included by previous but it doesn't so...

    echo -e "${GREEN}Installing Home Manager${NC}"
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell "<home-manager>" -A install

    $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

    echo -e "${GREEN}Building config${NC}"
    mkdir -p ~/.config/nix
    echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
    home-manager switch -b bak --flake ./dotfiles/#${1}

    echo -e "${GREEN}Done! Please restart your shell${NC}"
EOF

fi

if [ "$HOME_MANAGER" != "YES" ] && ([ "$INSTALL" == "YES" ] || [ "$EVERYTHING" == "YES" ]); then
  echo -e "${GREEN}Building for hostname \"$1\"${NC}"
  nixos-install --flake ${HOME_PATH}dotfiles#$1
  echo "Setting password for $USERNAME"
  nixos-enter --root /mnt -c "chown -R $USERNAME:$USERNAME /home/$USERNAME/dotfiles && passwd $USERNAME"

  echo -e "${GREEN}Done! You can reboot now${NC}"
fi
