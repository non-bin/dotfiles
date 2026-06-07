{ ... }:

{
  imports = [ ../../modules/home/server.nix ];

  home.sessionVariables = {
    NIX_HOMEMAN_STANDALONE_TYPE = "basic";
  };
}
