# nix eval --file dotfiles/test.nix

{
  home.sessionPath = [
    (builtins.toString ../scripts)
  ];
}
