{ config, pkgs, lib, ... }:

{
  imports = [
    ./common.nix
    ../../home/full.nix
  ];

  home.sessionVariables = {
    NIX_HOMEMAN_STANDALONE_TYPE="full";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
