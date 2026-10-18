{ ... }:

{
  imports = [ ../../modules/home/personal ];

  home.sessionVariables = {
    NIX_HOMEMAN_STANDALONE_TYPE = "full";
  };
}
