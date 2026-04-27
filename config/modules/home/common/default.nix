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

  xdg.enable = true;

  home.packages = with pkgs; [
    btop
    nix-search
    hwatch # better watch command
  ];

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      # https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/use-cases/ssh/ssh-cloudflared-authentication/
      matchBlocks = {
        "m" = {
          user = user.name;
          hostname = "ssh-m.jacka.net.au";
          proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
        };
        "s" = {
          user = user.name;
          hostname = "ssh-s.jacka.net.au";
          proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
        };
      };
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

      withRuby = false;
      withPython3 = false;
    };

    delta = {
      enable = true; # Syntax hilighting
      enableGitIntegration = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      signing.format = null; # "openpgp";

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
