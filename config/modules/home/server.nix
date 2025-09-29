{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./common
    ./server
  ];
}
