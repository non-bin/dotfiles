{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./base.nix
    ./regreet.nix
  ];
  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

  programs = {
    hyprland = {
      enable = true; # Enable system wide, configure in HM
      # Use the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # Make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    gamemode.enable = true;

    virt-manager.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  services = {
    ratbagd.enable = true; # For configuring gaming mice with Piper

    transmission = {
      package = pkgs.transmission_4;
      enable = true;
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ]; # For shared folders
    };

    spiceUSBRedirection.enable = true;
  };
}
