{ config, pkgs, lib, ... }:

{
  imports = [
    ./starship.nix
  ];

  home.shell.enableZshIntegration = true;

  # Check the name of the parent process. If
  programs.bash.initExtra = ''[ "$(basename "/"$(ps -o cmd -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/ .*$//'))" != "zsh" ] && echo hyfetch | zsh -t && exec zsh'';

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autocd = true; # Automatically enter into a directory if typed directly into shell
    enableVteIntegration = true; # Integration with terminals using the VTE library. This will let the terminal track the current working directory
    defaultKeymap = "emacs";

    loginExtra = "hyfetch";

    history = {
      append = true; # Sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their history lists added to the history file, in the order that they exit.
      expireDuplicatesFirst = true;
      extended = true; # Save timestamps
    };

    historySubstringSearch.enable = true;

    shellAliases = {
      grep = "grep --color=auto";

      ls = "ls -Fh --color=auto";
      ll = "ls -l";
      la = "ls -lA";
      l = "ls -C";

      mkdir = "mkdir -p";
      rm = "rm -r";
      rsync = "rsync -rlgopPEh --mkpath --info=PROGRESS2,STATS3,SKIP2";
      rcp = ''rsync -e /dev/null -b --backup-dir="/tmp/rsync-$USERNAME"'';
      rmv = "cp --remove-source-files";
      dfh = "df -xtmpfs -xefivarfs -xdevtmpfs -hT";

      code = "codium ";

      ns = "nix-shell --pure ";
      nsh = "nix-shell --run zsh ";
      get = "nsh -p ";
      locate = "nix run \"github:nix-community/nix-index#nix-locate\" -- ";
      search = "nix-search ";

      chrome = "get ungoogled-chromium --run chromium ";

      g = "git ";
    };

    initContent = lib.strings.concatLines [
      "setopt extendedglob nomatch"
      ''bindkey " " magic-space''
      ''bindkey "^[[1;5C" forward-word''
      ''bindkey "^[[1;5D" backward-word''
      ''bindkey "\ue000" delete-word # Unicode EXXX is reserved and unused so I pass this to from the terminal emulator for delete word right''

      "zstyle ':completion:*' auto-description 'specify: %d'"
      "zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix"
      "zstyle ':completion:*' expand prefix suffix"
      "zstyle ':completion:*' file-sort name"
      "zstyle ':completion:*' format 'Completing %d'"
      "zstyle ':completion:*' group-name ''"
      "zstyle ':completion:*' ignore-parents parent pwd .. directory"
      "zstyle ':completion:*' insert-unambiguous true"
      "zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}"
      "zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s"
      "zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'"
      "zstyle ':completion:*' match-original both"
      "zstyle ':completion:*' max-errors 2"
      "zstyle ':completion:*' menu select=1"
      "zstyle ':completion:*' original true"
      "zstyle ':completion:*' preserve-prefix '//[^/]##/'"
      "zstyle ':completion:*' prompt '%e errors. Maybe you meant...'"
      "zstyle ':completion:*' select-prompt %SScrolling active: current selection at %l%s"
      "zstyle ':completion:*' special-dirs true"
    ];
  };
}
