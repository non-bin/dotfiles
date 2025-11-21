{ pkgs, lib, ... }:

let
  javaVersions = with pkgs; [
    (temurin-jre-bin-8 // { meta.priority = 1300; }) # For minecraft 1.12
    (temurin-jre-bin-17 // { meta.priority = 1200; })
    (temurin-jre-bin-21 // { meta.priority = 1100; })
    (temurin-jre-bin // { meta.priority = 1000; })
  ];
in
{
  # ...
  programs.java = {
    # ...
  };

  home.packages = javaVersions;

  home.sessionPath = [ "$HOME/.jdks" ];
  home.file =
    (builtins.listToAttrs (
      builtins.map (jdk: {
        name = ".jdks/${jdk.version}";
        value = {
          source = jdk;
        };
      }) javaVersions
    ))
    // (builtins.listToAttrs (
      builtins.map (jdk: {
        name = ".jdks/java${builtins.head (lib.strings.splitString "." jdk.version)}";
        value = {
          source = "${jdk}/bin/java";
        };
      }) javaVersions
    ));
}
