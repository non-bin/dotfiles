{
  inputs,
  config,
  pkgs,
  lib,
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
    # zsh.shellAliases.code = "codium ";

    vscode = {
      enable = true;
      # package = pkgs.vscodium;

      mutableExtensionsDir = false;
      profiles.default = {
        # https://github.com/nix-community/nix4vscode
        extensions =
          with inputs.nix4vscode.outputs.lib.${pkgs.stdenv.hostPlatform.system};
          (
            [ ]
            # Themes
            ++ forVscode [ "PKief.material-icon-theme" ]
            ++ forVscode [ "github.github-vscode-theme" ]
            ++ forVscode [ "oderwat.indent-rainbow" ]

            # Languages
            ++ forVscode [ "yzhang.markdown-all-in-one" ]
            ++ forVscode [ "bierner.markdown-preview-github-styles" ]
            ++ forVscode [ "oven.bun-vscode" ]
            ++ forVscode [ "mechatroner.rainbow-csv" ]
            ++ forVscode [ "jnoortheen.nix-ide" ] # TODO https://github.com/nix-community/vscode-nix-ide?tab=readme-ov-file#lsp-plugin-support also is jeff-hykin.better-nix-syntax better?
            ++ forVscode [ "ms-vscode.cpptools" ]
            ++ forVscode [ "mikestead.dotenv" ]
            ++ forVscode [ "tamasfe.even-better-toml" ]
            ++ forVscode [ "ms-vscode.cmake-tools" ]
            ++ forVscode [ "llvm-vs-code-extensions.vscode-clangd" ]

            ++ forVscode [ "demijollamaxime.bulma" ] # 51k downloads
            # ++ forVscode [ "fiazluthfi.bulma-snippets" ] # 26k downloads
            # ++ forVscode [ "reliutg.bulma-css-class-completion" ] # 15k downloads

            # Utility
            ++ forVscode [ "jkillian.custom-local-formatters" ]
            ++ forVscode [ "aaron-bond.better-comments" ]
            ++ forVscode [ "usernamehw.errorlens" ]
            ++ forVscode [ "ms-vscode.hexeditor" ]
            ++ forVscode [ "mhutchie.git-graph" ]
            ++ forVscode [ "streetsidesoftware.code-spell-checker" ]
            ++ forVscode [ "VisualStudioExptTeam.vscodeintellicode" ]
            ++ forVscode [ "VisualStudioExptTeam.intellicode-api-usage-examples" ]
            ++ forVscode [ "VisualStudioExptTeam.vscodeintellicode-completions" ]
            ++ forVscode [ "christian-kohler.path-intellisense" ]
          );
      };
    };
  };
}
