# Alice's Dot Files

## Bootstraping

Follow [this guide in the manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual), up to and including `nixos-generate-config`  
Once it instructs you to edit `configuration.nix`, run

```bash
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- YOUR_HOSTNAME

# Or if you'd like to edit the config before installing
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- YOUR_HOSTNAME -d -c # To download and copy in the hardware config
# Edit away
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- YOUR_HOSTNAME -i # To finish the install
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

## Resources

[NixOS Package Search](https://search.nixos.org/packages)
[Nüschtos Options Search](https://search.n%C3%BCschtos.de)
