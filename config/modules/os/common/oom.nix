{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  systemd = {
    oomd.enableUserSlices = true;

    # Create a separate slice for nix-daemon that is
    # memory-managed by the userspace systemd-oomd killer
    slices."nix-daemon".sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "50%";
    };
    services."nix-daemon".serviceConfig = {
      Slice = "nix-daemon.slice";

      # If a kernel-level OOM event does occur anyway,
      # strongly prefer killing nix-daemon child processes
      OOMScoreAdjust = 1000;
    };
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    extraArgs =
      let
        catPatterns = patterns: builtins.concatStringsSep "|" patterns;
        preferPatterns = [
          "^nix$"
          "firefox"
          "spotify"
          "hercules-ci-age"
          "ipfs"
          "java" # If it's written in java it's uninmportant enough it's ok to kill it
          "Logseq"
        ];
        avoidPatterns = [
          "bash"
          "sshd"
          "systemd"
          "tmux"
          "zellij"
          "[Hh]yprland"
        ];
      in
      [
        "--prefer"
        "'${catPatterns preferPatterns}'"
        "--avoid"
        "'${catPatterns avoidPatterns}'"
      ];
    killHook = pkgs.writeShellScript "earlyoom-kill-hook" ''notify-send - u critical "OOM Killed $EARLYOOM_NAME" "$EARLYOOM_CMDLINE"'';
  };

  environment.systemPackages = [ pkgs.libnotify ];
}
