# nix eval --file dotfiles/repos/dotfiles/test.nix

{
  home.sessionPath = [
    (builtins.toString ../scripts)
  ];
}
