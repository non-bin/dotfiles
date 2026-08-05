#!/usr/bin/env bash
# set -x # Print commands as they are printed
set -e # Exit on any errors

# Colour codes. Use with `echo -e "${GREEN}I ${RED}love${NC} Stack Overflow"``
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../"

# Defaults
REBUILD="YES"
IMPURE=""
ACTION="switch"

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -R | --rescue)
      RESCUE="YES"
      shift # past argument
      ;;
    -o | --optimise)
      REBUILD="NO"
      OPTIMISE="YES"
      shift
      ;;
    -O | --offline)
      OFFLINE="--offline"
      shift
      ;;
    -p | --pull)
      PULL="YES"
      shift # past argument
      ;;
    -P | --push)
      PUSH="YES"
      shift # past argument
      ;;
    -u | --upgrade)
      UPGRADE="YES"
      shift # past argument
      ;;
    -C | --check)
      CHECK="YES"
      REBUILD="NO"
      shift # past argument
      ;;
    -v | --vm)
      VM="YES"
      shift # past argument
      ;;
    -t | --trace)
      TRACE="--show-trace"
      shift # past argument
      ;;
    -c | --clean)
      REBUILD="NO"
      CLEAN="YES"
      shift # past argument
      ;;
    -r | --rebuild)
      REBUILD="YES"
      shift # past argument
      ;;
    -k | --rekey)
      REKEY="YES"
      REBUILD="NO"
      shift # past argument
      ;;
    -d | --dry-run)
      DRY="YES"
      shift # past argument
      ;;
    -g | --generation)
      GENERATION="YES"
      REBUILD="NO"
      shift
      ;;
    -i | --impure)
      IMPURE="--impure"
      shift
      ;;
    -I | --pure)
      IMPURE=""
      shift
      ;;
    --sub)
      SUB="$2"
      SUBSTITUTERS="--option extra-substituters $2?trusted=true"
      shift # past argument
      shift # past param
      ;;
    -a | --auto)
      PULL="YES"
      CLEAN="YES"
      REBUILD="YES"
      shift
      ;;
    -b | --boot)
      ACTION="boot"
      shift
      ;;

    -* | --*)
      echo "Unknown option $1"

      echo "Usage: $0 [options] [new-config-name]"
      echo
      echo "Options:"
      echo "  -u, --upgrade     Pull updates from upstream and update lockfile"
      echo "  -i, --impure      Add the --impure flag to the reload command"
      echo "  -I, --pure        Remove the --impure flag from the reload command"
      echo "  -c, --clean       Garbage collect the nix store, don't rebuild (https://nixos.wiki/wiki/Cleaning_the_nix_store)"
      echo "  -o, --optimise    Hard link identicle files in the nix store, don't rebuild (https://nixos.wiki/wiki/Storage_optimization)"
      echo "  -O, --offline     Disable binary caches and consider all downloads up to date"
      echo "  -C, --check       Run 'nix flake check' to validate the config"
      echo "  -p, --pull        Pull updates from git before updating"
      echo "  -P, --push        Commit and push all changes"
      echo "  -r, --rebuild     Explicitly run the rebuild command (eg if running with -c or -o)"
      echo "  -g, --generation  Interactively switch to a previous generation"
      echo "  -k, --rekey       Generate and rekey agenix secrets"
      echo "  -v, --vm          Build and run a VM with 'nixos-rebuild build-vm', and expose port 22 through the host's port 2221"
      echo "  -d, --dry-run     Run everything but the rebuild command"
      echo "  -R, --rescue      Don't run any extra commands (like git)"
      echo "  -t, --trace       Pass --show-trace to rebuild command (for debuggin)"
      echo "  -b, --boot        Run 'nixos-rebuild boot' instead of 'switch', for breaking changes"
      echo "  --sub URL         Use the specified substituter (eg '--sub http://vmhost:5000' and 'nix run github:edolstra/nix-serve' on the host)"
      echo "  -a, --auto        Equivalent to '-c -p -r'"
      echo
      echo "Options must be specified with separate tacs (these: '-'). For example use '-u -c -P' not '-ucP"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift                   # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

NEW_CONFIG_NAME="$1"

if [ "$RESCUE" != "YES" ]; then
  systemd-inhibit --what=sleep --who="Reload script" --why="Updating" sleep infinity &
  INHIBIT_PID=$!

  # Ensure lock is released even if script crashes or receives SIGINT/SIGTERM
  trap 'kill "$INHIBIT_PID" 2>/dev/null' EXIT

  echo -e "${GREEN}[r] Wake lock acquired${NC}"
fi

if [ "$SUB" != "" ]; then
  echo -e "${GREEN}[r] Checking substituters...${NC}"
  if ! curl "$SUB/nix-cache-info" -m 3 || ! nix --extra-experimental-features nix-command store info --option connect-timeout 3 --option download-attempts 1 --store $SUB; then
    echo -e "${RED}[r] Failed to connect to substituter '$SUB'${NC}"
    exit 1
  fi
  echo -e "${GREEN}[r] Done${NC}"
fi

if [ "$CLEAN" == "YES" ]; then
  if [ "$NIX_HOMEMAN_STANDALONE_TYPE" != "" ]; then
    echo -e "${RED}[r] Standalone clean is not implemented${NC}"
    exit 1
  elif [ "$TERMUX_VERSION" != "" ]; then
    echo -e "${RED}[r] NOD clean is not implemented${NC}"
    exit 1
  else
    printf "${GREEN}[r] Removing unused store entries...${NC}" # nh prints a new line
    nh clean all
    echo -e "${GREEN}[r] Done${NC}"
  fi
fi

if [ "$OPTIMISE" == "YES" ]; then
  echo -e "${GREEN}[r] Merging duplicate store entries...${NC}"
  nix store optimise
  echo -e "${GREEN}[r] Done${NC}"
fi

if [ "$PULL" == "YES" ]; then
  echo -e "${GREEN}[r] Updating git repo...${NC}"
  git pull
  echo -e "${GREEN}[r] Done${NC}"
fi

if [ "$UPGRADE" == "YES" ]; then
  echo -e "${GREEN}[r] Updating flake...${NC}"
  nix $SUBSTITUTERS flake update
  echo -e "${GREEN}[r] Done${NC}"
fi

if [ "$CHECK" == "YES" ]; then
  echo -e "${GREEN}[r] Checking all configs...${NC}"

  for host in $(nix eval --no-warn-dirty ".#nixosConfigurations" --raw --apply 'hosts: builtins.concatStringsSep " " (builtins.attrNames hosts)'); do
    echo -e "${GREEN}[r] Checking $host...${NC}"
    nix eval --no-warn-dirty ".#nixosConfigurations.$host.config.system.build.toplevel.drvPath" >/dev/null || FAIL="YES"
  done

  if [ "$FAIL" == "YES" ]; then
    echo -e "${RED}[r] Checks failed${NC}"
    exit 1
  fi

  echo -e "${GREEN}[r] Done${NC}"
fi

if [ "$RESCUE" != "YES" ] && ([ "$REBUILD" == "YES" ] || [ "$REKEY" == "YES" ]); then
  UNTRACKED_FILES=$(git ls-files -o --exclude-standard)

  while IFS= read -r FILE || [[ -n $FILE ]]; do
    echo -e "${GREEN}[r] Adding untracked file $FILE${NC}"
    git add "$FILE" # Add all untracked files
  done < <(printf '%s' "$UNTRACKED_FILES")
fi

if [ "$REKEY" == "YES" ]; then
  echo -e "${GREEN}[r] Generating agenix key files...${NC}"
  agenix generate -a
  agenix rekey -a
  echo -e "${GREEN}[r] Done${NC}"
fi

if [ "$GENERATION" == "YES" ]; then
  if [ "$NIX_HOMEMAN_STANDALONE_TYPE" != "" ]; then
    bash $(home-manager generations | fzf | awk -F '-> ' '{print $2 "/activate"}')
  elif [ "$TERMUX_VERSION" != "" ]; then
    generation=$(nix-on-droid generations | fzf | awk '{print $1}')

    if [ -z "$generation" ]; then
      echo -e "${RED}[r] No generation selected${NC}"
      exit 1
    fi

    nix-on-droid switch-generation "$generation"
  else
    generation=$(nixos-rebuild list-generations | awk 'NR==1 { header=$0; next } 1' | fzf --header "$(nixos-rebuild list-generations | head -n1)" | awk '{print $1}')

    if [ -z "$generation" ]; then
      echo -e "${RED}[r] No generation selected${NC}"
      exit 1
    fi

    # if current generation is selected, do nothing
    if [ "$(readlink /nix/var/nix/profiles/system)" = "system-$generation-link" ]; then
      echo -e "${RED}[r] Selected generation is already active${NC}"
      exit 0
    fi

    sudo nix-env --switch-generation "$generation" -p /nix/var/nix/profiles/system
    sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
  fi
fi

if [ "$DRY" != "YES" ] && [ "$REBUILD" == "YES" ]; then
  echo -e "${GREEN}[r] Rebuilding...${NC}"
  if [ "$NIX_HOMEMAN_STANDALONE_TYPE" == "" ]; then
    if [ "$VM" == "YES" ]; then
      [ "$NEW_CONFIG_NAME" == "" ] && NEW_CONFIG_NAME="testvm"
      QEMU_NET_OPTS="hostfwd=tcp::2221-:22" && nixos-rebuild build-vm $TRACE --flake ./#$NEW_CONFIG_NAME && "result/bin/run-${NEW_CONFIG_NAME}-vm" -nographic
      # rm result "${NEW_CONFIG_NAME}.qcow2"
    elif [ "$TERMUX_VERSION" != "" ]; then
      [ "$NEW_CONFIG_NAME" == "" ] && NEW_CONFIG_NAME="default"
      nix-on-droid switch $TRACE --flake ./#$NEW_CONFIG_NAME
    else
      nixos-rebuild $SUBSTITUTERS $OFFLINE $ACTION --sudo $IMPURE $TRACE --flake ./#$NEW_CONFIG_NAME
      # nixos-rebuild switch --sudo --flake ~/dotfiles
    fi
  else
    [ "$NEW_CONFIG_NAME" == "" ] && NEW_CONFIG_NAME=$NIX_HOMEMAN_STANDALONE_TYPE
    home-manager switch -b bak $IMPURE $TRACE --flake ./#$NEW_CONFIG_NAME
  fi
fi

if [ "$RESCUE" != "YES" ]; then
  kill "$INHIBIT_PID" 2>/dev/null
  trap - EXIT

  echo -e "${GREEN}[r] Released wake lock${NC}"
fi
