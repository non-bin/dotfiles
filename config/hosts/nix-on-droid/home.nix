{ ... }:

{
  imports = [ ../../modules/home/server.nix ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
