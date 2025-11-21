{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./base.nix

    ./shell
    ./java.nix
  ];

  home.packages = with pkgs; [
    bc
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
    zellij = {
      enable = true;
    };

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

    delta = {
      enable = true; # Syntax hilighting
      enableGitIntegration = true;
    };

    git = {
      enable = true;

      settings = {
        credential.helper = "store";
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [
          "gh:"
          "github:"
        ];
        user = {
          email = "jacka.alice@gmail.com";
          name = "Alice Jacka";
      };
        alias = {
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

    pay-respects = {
      # TheFuck replacement https://github.com/iffse/pay-respects
      enable = true;
      enableZshIntegration = true;
    };
  };
}
