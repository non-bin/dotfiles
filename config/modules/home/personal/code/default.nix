{
  config,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.nixd ];

  home.file.".config/Code/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/code/settings.jsonc";
  home.file.".config/Code/User/keybindings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/code/keybindings.jsonc";
  home.file.".config/Code/User/snippets".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/code/snippets";

  programs = {
    vscode = {
      enable = true;

      mutableExtensionsDir = true;
      profiles.default = {
        # https://github.com/nix-community/nix-vscode-extensions
        extensions = with pkgs; [
          # Themes
          vscode-marketplace.pkief.material-icon-theme
          vscode-marketplace.github.github-vscode-theme
          vscode-marketplace.oderwat.indent-rainbow
          vscode-marketplace.ms-vscode-remote.remote-containers

          # Languages
          vscode-marketplace.yzhang.markdown-all-in-one
          vscode-marketplace.bierner.markdown-preview-github-styles
          vscode-marketplace.oven.bun-vscode
          vscode-marketplace.mechatroner.rainbow-csv
          vscode-marketplace.jnoortheen.nix-ide
          vscode-marketplace.ms-vscode.cpptools
          vscode-marketplace.mikestead.dotenv
          vscode-marketplace.tamasfe.even-better-toml
          vscode-marketplace.ms-vscode.cmake-tools
          vscode-marketplace.llvm-vs-code-extensions.vscode-clangd

          vscode-marketplace.demijollamaxime.bulma

          # Utility
          vscode-marketplace.jkillian.custom-local-formatters
          vscode-marketplace.aaron-bond.better-comments
          vscode-marketplace.usernamehw.errorlens
          vscode-marketplace.ms-vscode.hexeditor
          vscode-marketplace.mhutchie.git-graph
          vscode-marketplace.streetsidesoftware.code-spell-checker
          vscode-marketplace.visualstudioexptteam.vscodeintellicode
          vscode-marketplace.visualstudioexptteam.intellicode-api-usage-examples
          vscode-marketplace.visualstudioexptteam.vscodeintellicode-completions
          vscode-marketplace.christian-kohler.path-intellisense

          vscode-marketplace.github.copilot-chat
          vscode-marketplace.johnny-zhao.oai-compatible-copilot
        ];
      };
    };
  };
}
