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

- Backups
- Skell
  - Homerow mods
- Maureen
  - https://kilo.bytesize.xyz/gpu-passthrough-on-nixos
  - https://pieterbakker.com/set-mdadm-to-send-e-mail-notifications/
  - https://pieterbakker.com/using-ssmtp-to-send-emails-from-a-linux-system/
  - https://nix.dev/tutorials/nixos/binary-cache-setup#setup-http-binary-cache
  - https://wiki.nixos.org/wiki/Binary_Cache
  - services.recyclarr.enable
