{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ./shell/zsh.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.sessionPath = [
    "$HOME/dotfiles/scripts"
  ];

  home.sessionVariables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
