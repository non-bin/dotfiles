{ pkgs, ... }:

let
  javaVersions =
    with pkgs;
    let
      jre-17 = temurin-jre-bin-17.overrideAttrs (oldAttrs: {
        meta.priority = 1200;
      });
      jre-21 = temurin-jre-bin-21.overrideAttrs (oldAttrs: {
        meta.priority = 1100;
      });
      jre = temurin-jre-bin.overrideAttrs (oldAttrs: {
        meta.priority = 1000;
      });
    in
    [
      jre-17
      jre-21
      jre
    ];
in
{
  # ...
  programs.java =
    {
      # ...
    };

  home.packages = javaVersions;

  home.sessionPath = [ "$HOME/.jdks" ];
  home.file = (
    builtins.listToAttrs (
      builtins.map (jdk: {
        name = ".jdks/${jdk.version}";
        value = {
          source = jdk;
        };
      }) javaVersions
    )
  );
}
