{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file.".treefmt.toml".source = ../../../../../treefmt.toml;
  home.file.".prettierrc.json".source = ./.prettierrc.json;

  # home.file.".treefmt.toml".source =
  #   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/treefmt.toml";
  # home.file.".prettierrc.json".source =
  #   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/formatters/.prettierrc.json";

  home.packages = with pkgs; [
    treefmt # multiplexer
    prettier # lots of languages
    nixfmt # nix
    shfmt # shell scripts
    taplo # toml
  ];
}
