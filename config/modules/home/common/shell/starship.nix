{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    starship = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      enableTransience = true;

      settings = {
        # Get editor completions based on the config schema
        # https://starship.rs/config

        format = lib.concatStrings [
          "[](#9A348E)"
          "$os"
          "$shell"
          "$username"
          "$hostname"
          "$docker_context"
          "$nix_shell"
          "[](bg:#DA627D fg:#9A348E)"

          "$directory"
          "[](fg:#DA627D bg:#FCA17D)"

          "$git_branch"
          "$git_status"
          "[](fg:#FCA17D bg:#86BBD8)"

          "$c"
          "$elixir"
          "$elm"
          "$golang"
          "$gradle"
          "$haskell"
          "$java"
          "$julia"
          "$nodejs"
          "$nim"
          "$rust"
          "$scala"
          "[](fg:#86BBD8 bg:#06969A)"

          "$time"
          "$character"
        ];

        continuation_prompt = "[](fg:#DA627D)[ ](bg:#DA627D)[](fg:#DA627D)";

        # Disable the blank line at the start of the prompt
        add_newline = false;

        character = {
          error_symbol = "[](fg:#06969A bg:#ff3131)[](#ff3131)";
          format = "$symbol ";
          success_symbol = "[](fg:#06969A bg:#33658A)[](fg:#33658A)";
        };

        shell = {
          disabled = false;
          format = "[$indicator ]($style)";
          style = "bg:#9A348E";
          unknown_indicator = "ukn";
          zsh_indicator = "";
        };

        username = {
          style_user = "bg:#9A348E";
          style_root = "bold fg:#00FFAB bg:#9A348E";
          format = "[$user ]($style)";
          disabled = false;
        };

        os = {
          style = "bg:#9A348E";
          disabled = false; # Disabled by default
          symbols = {
            NixOS = "";
          };
        };

        nix_shell = {
          disabled = false;
          format = "[via nsh ]($style)";
          symbol = "❄️ ";
          style = "bg:#9A348E";
          unknown_msg = "";
          heuristic = false;
        };

        hostname = {
          ssh_only = true; # Defaults to true
          style = "bg:#9A348E";
          format = "[@$hostname ]($style)";
          ssh_symbol = "🌏";
        };

        directory = {
          style = "bg:#DA627D";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
        };

        # Here is how you can shorten some long paths by text replacement
        # similar to mapped_locations in Oh My Posh:
        directory.substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          # Keep in mind that the order matters. For example:
          # "Important Documents" = " 󰈙 "
          # will not be replaced, because "Documents" was already substituted before.
          # So either put "Important Documents" before "Documents" or use the substituted version:
          # "Important 󰈙 " = " 󰈙 "
        };

        c = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        docker_context = {
          symbol = " ";
          style = "bg:#06969A";
          format = "[ $symbol $context]($style)";
        };

        elixir = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        elm = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        git_branch = {
          symbol = "";
          style = "bg:#FCA17D";
          format = "[ $symbol $branch ]($style)";
        };

        git_status = {
          style = "bg:#FCA17D";
          format = "[$all_status$ahead_behind ]($style)";
        };

        golang = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        gradle = {
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        haskell = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        julia = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        nim = {
          symbol = "󰆥 ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        scala = {
          symbol = " ";
          style = "bg:#86BBD8";
          format = "[ $symbol ($version) ]($style)";
        };

        time = {
          disabled = true;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#33658A";
          format = "[ ♥ $time ]($style)";
        };
      };
    };
  };
}
