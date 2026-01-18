{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ];

  home.shell.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autocd = true; # Automatically enter into a directory if typed directly into shell
    enableVteIntegration = true; # Integration with terminals using the VTE library. This will let the terminal track the current working directory
    defaultKeymap = "emacs";

    history = {
      append = true; # Sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their history lists added to the history file, in the order that they exit.
      expireDuplicatesFirst = true;
      extended = true; # Save timestamps
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[OA" ]; # Usually "^[[A"
      searchDownKey = [ "^[OB" ]; # Usually "^[[B"
    };

    shellAliases = {
      ls = "ls -Fh --color=auto";
      ll = "ls -l";
      la = "ls -lA";
      l = "ls -C";

      r = "reload.sh ";
      grep = "grep --color=auto";
      chrome = "get ungoogled-chromium --run chromium ";
      g = "git ";
      mkdir = "mkdir -p";
      rm = "rm -r";

      # -r            Recurse into directories
      # -l            Copy simlinks as simlinks
      # -gopE         Preserve group, owner, permissions, executability
      # -P            Keep partialy transferred files, and show progress
      # -h            Human readable numbers
      # --mkpath      Create all missing path components to destination
      # --info        What to log:
      #   PROGRESS2   Total ongoing transfer progress
      #   STATS3      Statistics at the end of the run
      #   SKIP2       Skipped files as they are skipped
      rsync = "rsync -rlgopEPh --mkpath --info=PROGRESS2,STATS3";
      # -e  Do not use a remote shell program (for local copy)
      # -b  Make backups in --backup-dir
      rcp = ''rsync -e /dev/null -b --backup-dir="/tmp/rsync-$USERNAME"'';
      rmv = "cp --remove-source-files";
      dfh = "df -xtmpfs -xefivarfs -xdevtmpfs -hT";
      duh = "du -h --summarize ";
      z = "zellij ";
      za = "z a ";

      ns = "nix-shell --log-format bar-with-logs --pure ";
      nsh = "nix-shell --log-format bar-with-logs --run zsh ";
      get = "nsh -p ";
      search = "nix-search ";
    };

    initContent = lib.strings.concatLines [
      "hyfetch"
      ''sshrm() {sed -i "/^$1/d" ~/.ssh/known_hosts}'' # Remove an ssh host key
      # ''export -f sshrm''

      ''err()(set -o pipefail;"$@" 2> >(sed $'s,.*,\e[31m&\e[m,'>&2))'' # Colour stderr red
      # ''export -f color''

      "WORDCHARS='*?_-.~=&;$%^'"
      "disable r"

      "setopt extendedglob nomatch"
      ''bindkey " " magic-space''
      ''bindkey "^[[1;5C" forward-word''
      ''bindkey "^[[1;5D" backward-word''
      ''bindkey "^[[3~" delete-char''
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
