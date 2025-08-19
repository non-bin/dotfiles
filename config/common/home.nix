{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/home/shell/zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.sessionPath = [
    "$HOME/dotfiles/scripts"
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
    fzf
    nix-search
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

      aliases = {
        co = "checkout";
        cl = "clone";
        br = "branch";
        ci = "commit";
        st = "status";
        pl = "pull";
        ps = "push";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
