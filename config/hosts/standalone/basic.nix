{ ... }:

{
  imports = [ ../../modules/home/server ];

  home.sessionVariables = {
    NIX_HOMEMAN_STANDALONE_TYPE = "basic";
  };
}
