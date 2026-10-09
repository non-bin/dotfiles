{
  config,
  lib,
  pkgs,
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
      hardware.graphics.enable = lib.mkDefault anyGpu;

      # Allow viewing performance without root
      hardware.intel-gpu-tools.enable = lib.mkDefault config.hardware.intelgpu.enable;
      security.wrappers.btop = lib.mkIf config.hardware.intelgpu.enable {
        owner = "root";
        group = "root";
        source = "${pkgs.btop}/bin/btop";
        capabilities = "cap_perfmon+ep";
      };
    };
}
