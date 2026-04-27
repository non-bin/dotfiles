{
  config,
  pkgs,
  lib,
  user,
  ...
}:

{
  imports = [ ./shell/zsh.nix ];

  home.packages = with pkgs; [
    wget
    zip
    unzip
    traceroute
    jq
    fzf
    gawk
    file
    patchelf
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = lib.mkDefault user.name;
  home.homeDirectory = lib.mkDefault "/home/${user.name}";
  home.sessionPath = [ "$HOME/dotfiles/scripts" ];

  home.sessionVariables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
