{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./common
    ./personal
  ];
}
