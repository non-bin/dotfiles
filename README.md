# Alice's Dot Files

## Bootstraping

Follow [this guide in the manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual), up to and including `nixos-generate-config`  
Once it instructs you to edit `configuration.nix`, run

```bash
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME

# Or if you'd like to edit the config before installing
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME -d -c # To download and copy in the hardware config
# Edit away
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME -i # To finish the install

# Or to disable copying hardware config
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME -d -i

# Or to quickly setup a VM
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME --vm
```

```
Usage: bootstrap.sh [options] hostname

Options:
  -d, --download    Clone the dotfiles to /mnt. Implies -n
  -u, --upgrade     Update flake.lock to the latest versions before installing
  -c, --copy        Copying hardware config. Implies -n
  -i, --install     Install with the flake as input. Implies -n
  -e, --everything  Implied unless other switches are passed. Download, copy and install. Equivilent to '-d -c -i'
  -n, --nothing     Require explicitly enabling any steps you want
  --vm              Quickly setup from within a VM. Partition vda, generate hardware config, and mount virtiofs dotfiles if available
  --user username   Set the username for the user to create. YOU NEED TO UPDATE CONFIGURATION.NIX TO CREATE THE USER
```

## Reloading Config

```
Usage: reload [options] [new-hostname]

Options:
  -u, --upgrade     Add pull updates from upstream and update lockfile
  -t, --show-trace  Pass --show-trace to rebuild command (for debuggin)
  -P, --pull        Pull updates from git before updating
```

### TODO

- hyprpolkitagent
- waybar

- network
- evremap
- hardware.cpu.amd.updateMicrocode
- audio
- bluetooth
- brightness
- check https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/ works
- check screenshots work

- wl-clip-persist
- hyprpaper
- wlogout
- eslint

- fingerprint
  - Hyprlock
  - Regreet
  - sudo
  - polkit
- fastfetch
- minecraft

- Reload script
  - update schedule
  - cleanup
  - git actions
  - dry run
  - better param parsing

## Resources

[NixOS Package Search](https://search.nixos.org/packages)
[Nüschtos Options Search](https://search.n%C3%BCschtos.de)
