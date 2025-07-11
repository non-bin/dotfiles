# Alice's Dot Files

## Bootstraping

Follow [this guide in the manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual), up to and including `nixos-generate-config`  
Once it instructs you to edit `configuration.nix`, run

```bash
sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME

sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME --help # For usage

# Or if you'd like to edit the config before installing
sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME -d -c -v # To download, copy the hardware config, and update stateVersion
# Edit away
sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME -i # To finish the install

# Or to disable copying hardware config
sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME -d -v -i

# Or setup just the package and home managers (for non NixOS hosts)
sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME -h
# Or if you don't habe curl
sudo bash -c "$(wget -qO- jacka.net.au/dotfiles)" -- HOSTNAME -h

# Or to quickly setup a VM
sudo bash -c "$(curl -L jacka.net.au/dotfiles)" -- HOSTNAME --vm
```

## TODO

- GhostyTerm
- hardware.cpu.amd.updateMicrocode
- check <https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/> works
- check screenshots work

- <https://keyboard.frame.work> <https://community.frame.work/t/responded-help-configuring-fw16-keyboard-with-via/47176/5>
- wl-clip-persist
- hyprpaper
- eslint
- btrbk

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
