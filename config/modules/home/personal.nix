{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./common
    ./personal
  ];
}
