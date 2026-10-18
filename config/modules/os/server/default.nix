{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../common
  ];

  services.udev.extraRules =
    let
      mkRule = as: lib.concatStringsSep ", " as;
      mkRules = rs: lib.concatStringsSep "\n" rs;
    in
    mkRules [
      (mkRule [
        ''ACTION=="add|change"''
        ''SUBSYSTEM=="block"''
        ''KERNEL=="sd[a-z]"''
        ''ATTR{queue/rotational}=="1"''

        # -B: Aggressiveness (lower is more agressive, 1-127 permit spindown BEFORE STANDBY TIME)
        # -S: Standby time (Incriments of 5 seconds for values 1-240. eg 120*5seconds = 10minutes)
        ''RUN+="${pkgs.hdparm}/bin/hdparm -B 254 -S 120 /dev/%k"''
      ])
    ];
}
