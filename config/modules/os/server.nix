{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./common
    ./server
  ];
}
