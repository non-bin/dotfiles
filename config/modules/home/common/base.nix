{
  config,
  pkgs,
  lib,
  user,
  ...
}:

{
  imports = [ ./shell/zsh.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = user.name;
  home.homeDirectory = "/home/${user.name}";
  home.sessionPath = [ "$HOME/dotfiles/scripts" ];

  home.sessionVariables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
