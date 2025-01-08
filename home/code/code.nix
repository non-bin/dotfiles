{ config, pkgs, lib, ... }:

# home-manager.users.alice =
{
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      userSettings = import ./settings.nix;
      keybindings = builtins.fromJSON (builtins.readFile ./keybindings.jsonc);

      extensions = with pkgs.vscode-extensions; [
        # Themes
        pkief.material-icon-theme
        github.github-vscode-theme
        pkief.material-product-icons
        oderwat.indent-rainbow
        # kshetline.ligatures-limited

        # Languages
        yzhang.markdown-all-in-one
        bierner.markdown-preview-github-styles
        davidanson.vscode-markdownlint

        mechatroner.rainbow-csv
        jnoortheen.nix-ide
        ms-vscode.cpptools
        streetsidesoftware.code-spell-checker

        # Formatters
        # Astyle
        dbaeumer.vscode-eslint
        visualstudioexptteam.vscodeintellicode
        christian-kohler.path-intellisense
        esbenp.prettier-vscode

        # Utility
        aaron-bond.better-comments
        usernamehw.errorlens
        ms-vscode.hexeditor
        mhutchie.git-graph
      ];
    };
  };
}
