{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./fetch.nix
    ./zellij.nix
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
