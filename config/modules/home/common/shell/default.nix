{ ... }:

{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./fetch.nix
    ./zellij.nix
  ];

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        RESET = "0";
        DIR = "01;34";
        LINK = "01;36";
        MULTIHARDLINK = "00";
        FIFO = "33";
        SOCK = "01;35";
        DOOR = "01;35";
        BLK = "01;33";
        CHR = "01;33";
        ORPHAN = "01;31";
        MISSING = "00";
        SETUID = "37;41";
        SETGID = "30;43";
        CAPABILITY = "30;41";
        STICKY_OTHER_WRITABLE = "30;42";
        OTHER_WRITABLE = "33";
        STICKY = "37;44";
        EXEC = "01;32";
      };
    };
  };
}
