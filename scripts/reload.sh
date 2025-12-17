#!/usr/bin/env bash
# set -x # Print commands as they are printed
set -e # Exit on any errors

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../"

# Defaults
REBUILD="YES"
IMPURE=""

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

    -* | --*)
      echo "Unknown option $1"

      echo "Usage: $0 [options] [new-config-name]"
      echo
      echo "Options:"
      echo "  -u, --upgrade     Pull updates from upstream and update lockfile"
      echo "  -i, --impure      Add the --impure flag to the reload command"
      echo "  -I, --pure        Remove the --impure flag from the reload command"
      echo "  -c, --clean       Garbage collect the nix store, don't rebuild (more info at https://nixos.wiki/wiki/Cleaning_the_nix_store and https://nixos.wiki/wiki/Storage_optimization)"
      echo "  -o, --optimise    Hard link identicle files in the nix store, don't rebuild"
      echo "  -p, --pull        Pull updates from git before updating"
      echo "  -P, --push        Commit and push all changes"
      echo "  -r, --rebuild     Explicitly run the rebuild command (eg if running with -c or -o)"
      echo "  -k, --rekey       Generate and rekey agenix secrets"
      echo "  -v, --vm          Build and run a VM with 'nixos-rebuild build-vm', and expose port 22 through the host's port 2221"
      echo "  -d, --dry-run     Run everything but the rebuild command"
      echo "  -R, --rescue      Don't run any extra commands (like git)"
      echo "  -t, --trace       Pass --show-trace to rebuild command (for debuggin)"
      echo "  --sub URL         Use the specified substituter (eg '--sub http://vmhost:5000' and 'nix run github:edolstra/nix-serve' on the host)"
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

if [ "$SUB" != "" ]; then
  if ! curl "$SUB/nix-cache-info" -m 3 || ! nix --extra-experimental-features nix-command store info --option connect-timeout 3 --option download-attempts 1 --store $SUB; then
    echo -e "Failed to connect to substituter '$SUB'"
    exit 1
  fi
fi

if [ "$CLEAN" == "YES" ]; then
  [ "$NIX_HOMEMAN_STANDALONE_TYPE" == "" ] && sudo nix-collect-garbage --delete-older-than 1d # Delete old system generations, and their store entries
fi

if [ "$OPTIMISE" == "YES" ]; then
  nix-store --optimise # Can be scheduled with `nix.optimise.automatic = true;`, or run on every build with `nix.settings.auto-optimise-store = true;`, but this doesn't catch everything
fi

if [ "$PULL" == "YES" ]; then
  git pull
fi

if [ "$PUSH" == "YES" ]; then
  git add *
  git commit
  git push
fi

if [ "$UPGRADE" == "YES" ]; then
  nix $SUBSTITUTERS flake update
  echo "Finished update"
  echo
fi

if [ "$RESCUE" != "YES" ] && ([ "$REBUILD" == "YES" ] || [ "$REKEY" == "YES" ]); then
  UNTRACKED_FILES=$(git ls-files -o --exclude-standard)

  while IFS= read -r FILE || [[ -n $FILE ]]; do
    echo "Adding untracked file $FILE"
    git add "$FILE" # Add all untracked files
  done < <(printf '%s' "$UNTRACKED_FILES")
fi

if [ "$REKEY" == "YES" ]; then
  agenix generate -a
  agenix rekey -a
fi

if [ "$GENERATION" == "YES" ]; then
  bash $(home-manager generations | fzf | awk -F '-> ' '{print $2 "/activate"}')
fi

if [ "$DRY" != "YES" ] && [ "$REBUILD" == "YES" ]; then
  if [ "$NIX_HOMEMAN_STANDALONE_TYPE" == "" ]; then
    if [ "$VM" == "YES" ]; then
      [ "$NEW_CONFIG_NAME" == "" ] && NEW_CONFIG_NAME="testvm"
      QEMU_NET_OPTS="hostfwd=tcp::2221-:22" && nixos-rebuild build-vm $TRACE --flake ./#$NEW_CONFIG_NAME && "result/bin/run-${NEW_CONFIG_NAME}-vm" -nographic
      # rm result "${NEW_CONFIG_NAME}.qcow2"
    else
      nixos-rebuild $SUBSTITUTERS switch --sudo $IMPURE $TRACE --flake ./#$NEW_CONFIG_NAME
    fi
  else
    [ "$NEW_CONFIG_NAME" == "" ] && NEW_CONFIG_NAME=$NIX_HOMEMAN_STANDALONE_TYPE
    home-manager switch -b bak $IMPURE $TRACE --flake ./#$NEW_CONFIG_NAME
  fi
fi
