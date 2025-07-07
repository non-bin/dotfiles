{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/zsh/zsh.nix
    ./modules/fetch.nix
  ];

  home.sessionVariables = {
    SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    wget
    btop
    zip
    unzip
    traceroute
    jq
  ];

  programs = {
    bash.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      extraConfig = ''
        set autoindent expandtab tabstop=2 shiftwidth=2
        set number
        if &diff
          colorscheme blue
        endif
      '';
    };

    git = {
      enable = true;
      delta.enable = true; # Syntax hilighting
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [ "gh:" "github:" ];
      };
      userEmail = "jacka.alice@gmail.com";
      userName = "Alice Jacka";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
