{
  config,
  lib,
  ...
}:

{
  options.hardware = {
    amdgpu.enable = lib.mkEnableOption "Enable AMD GPU features";
    intelgpu.enable = lib.mkEnableOption "Enable Intel GPU features";
    nvidia.enable = lib.mkEnableOption "Enable nvidia GPU features";
  };

  config = {
    hardware.intel-gpu-tools.enable = config.hardware.intelgpu.enable; # Allow viewing performance without root
  };
}
