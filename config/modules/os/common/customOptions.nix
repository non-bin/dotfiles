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

  config =
    let
      anyGpu =
        config.hardware.intelgpu.enable or config.hardware.nvidia.enable or config.hardware.amdgpu.enable;
    in
    {
      hardware.intel-gpu-tools.enable = lib.mkDefault config.hardware.intelgpu.enable; # Allow viewing performance without root
      hardware.graphics.enable = lib.mkDefault anyGpu;
    };
}
