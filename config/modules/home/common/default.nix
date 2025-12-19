{
  config,
  pkgs,
  lib,
  user,
  ...
}:

{
  imports = [
    ./base.nix

    ./shell
  ];

  home.packages = with pkgs; [
    wget
    btop
    zip
    unzip
    traceroute
    jq
    fzf
    nix-search
    file
    patchelf
    hwatch # better watch command
  ];

  programs = {
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
          email = user.email;
          name = user.fullName;
        };
        alias = {
          co = "checkout";
          cl = "clone";
          br = "branch";
          ci = "commit";
          st = "status";
          pl = "pull";
          ps = "push";
          rs = "reset";
          rh = "reset --hard HEAD";
        };
      };
    };

    # FIXME:
    pay-respects = {
      # TheFuck replacement https://github.com/iffse/pay-respects
      enable = true;
      enableZshIntegration = true;
    };
  };
}
