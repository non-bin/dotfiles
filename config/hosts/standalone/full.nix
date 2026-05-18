{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ../../modules/home/personal.nix ];

  home.sessionVariables = {
    NIX_HOMEMAN_STANDALONE_TYPE = "full";
  };
}
