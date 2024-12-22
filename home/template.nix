{ config, pkgs, lib, ... }:

# DON'T FORGET TO IMPORT INTO HOME.NIX

# home-manager.users.alice =
{
  imports = [
  ];

  home.packages = with pkgs; [
  ];

  home.file = {
    # ".aspell.conf".text = ''
    # master en_AU
    # extra-dicts en-computers.rws
    # add-extra-dicts en_GB-science.rws
    # '';
  };

  programs = {
  };

  services = {
  };
}
