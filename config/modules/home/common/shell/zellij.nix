{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zellij.enable = true;

  # TODO: don't hardcode urls, and use module settings
  home.file = {
    ".config/zellij/config.kdl".text = ''
      show_startup_tips false

      plugins {
        zjstatus location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm"
        zjstatus-hints location="https://github.com/b0o/zjstatus-hints/releases/latest/download/zjstatus-hints.wasm" {
          // Maximum number of characters to display
          max_length 0 // 0 = unlimited
          // String to append when truncated
          overflow_str "..." // default
          // Name of the pipe for zjstatus integration
          pipe_name "zjstatus_hints" // default
          // Hide hints in base mode (a.k.a. default mode)
          // E.g. if you have set default_mode to "locked", then
          // you can hide hints in the locked mode by setting this to true
          hide_in_base_mode false // default
        }
      }

      load_plugins {
        // Load at startup
        zjstatus-hints
      }
    '';

    # https://github.com/wiraki/dotfiles/blob/c6a120207916d7eefa330188968f1dd8c4400f4d/private_dot_config/zellij/layouts/default.kdl#L4
    ".config/zellij/layouts/default.kdl".text = ''
      layout {
        swap_tiled_layout name="vertical" {
          tab max_panes=5 {
            pane split_direction="vertical" {
              pane
              pane { children; }
            }
          }
          tab max_panes=8 {
            pane split_direction="vertical" {
              pane { children; }
              pane { pane; pane; pane; pane; }
            }
          }
          tab max_panes=12 {
            pane split_direction="vertical" {
              pane { children; }
              pane { pane; pane; pane; pane; }
              pane { pane; pane; pane; pane; }
            }
          }
        }

        swap_tiled_layout name="horizontal" {
          tab max_panes=5 {
            pane
            pane
          }
          tab max_panes=8 {
            pane {
              pane split_direction="vertical" { children; }
              pane split_direction="vertical" { pane; pane; pane; pane; }
            }
          }
          tab max_panes=12 {
            pane {
              pane split_direction="vertical" { children; }
              pane split_direction="vertical" { pane; pane; pane; pane; }
              pane split_direction="vertical" { pane; pane; pane; pane; }
            }
          }
        }

        swap_tiled_layout name="stacked" {
          tab min_panes=5 {
            pane split_direction="vertical" {
              pane
              pane stacked=true { children; }
            }
          }
        }

        swap_floating_layout name="staggered" {
          floating_panes
        }

        swap_floating_layout name="enlarged" {
          floating_panes max_panes=10 {
            pane { x "5%"; y 1; width "90%"; height "90%"; }
            pane { x "5%"; y 2; width "90%"; height "90%"; }
            pane { x "5%"; y 3; width "90%"; height "90%"; }
            pane { x "5%"; y 4; width "90%"; height "90%"; }
            pane { x "5%"; y 5; width "90%"; height "90%"; }
            pane { x "5%"; y 6; width "90%"; height "90%"; }
            pane { x "5%"; y 7; width "90%"; height "90%"; }
            pane { x "5%"; y 8; width "90%"; height "90%"; }
            pane { x "5%"; y 9; width "90%"; height "90%"; }
            pane focus=true { x 10; y 10; width "90%"; height "90%"; }
          }
        }

        swap_floating_layout name="spread" {
          floating_panes max_panes=1 {
            pane {y "50%"; x "50%"; }
          }
          floating_panes max_panes=2 {
            pane { x "1%"; y "25%"; width "45%"; }
            pane { x "50%"; y "25%"; width "45%"; }
          }
          floating_panes max_panes=3 {
            pane focus=true { y "55%"; width "45%"; height "45%"; }
            pane { x "1%"; y "1%"; width "45%"; }
            pane { x "50%"; y "1%"; width "45%"; }
          }
          floating_panes max_panes=4 {
            pane { x "1%"; y "55%"; width "45%"; height "45%"; }
            pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
            pane { x "1%"; y "1%"; width "45%"; height "45%"; }
            pane { x "50%"; y "1%"; width "45%"; height "45%"; }
          }
        }

        default_tab_template {
          pane size=1 borderless=true {
            plugin location="zjstatus" {
              format_left   "{mode}#[bg=#181926] {tabs}"
              format_center ""
              format_right  "{swap_layout} #[bg=#181926,fg=##777777] {command_username}@{command_hostname}: {session}"
              format_space  "#[bg=#181926]"
              format_hide_on_overlength "false"
              format_precedence "crl"

              border_enabled  "false"
              border_char   "─"
              border_format   "#[fg=#6C7086]{char}"
              border_position "top"

              hide_frame_for_single_pane "true"

              mode_normal    "#[bg=#a6da95,fg=#181926,bold] NORMAL#[bg=#181926,fg=#a6da95]"
              mode_locked    "#[bg=#6e738d,fg=#181926,bold] LOCKED  #[bg=#181926,fg=#6e738d]"
              mode_resize    "#[bg=#8aadf4,fg=#181926,bold] RESIZE#[bg=#181926,fg=#8aadf4]"
              mode_pane      "#[bg=#8aadf4,fg=#181926,bold] PANE#[bg=#181926,fg=#8aadf4]"
              mode_tab       "#[bg=#8aadf4,fg=#181926,bold] TAB#[bg=#181926,fg=#8aadf4]"
              mode_scroll    "#[bg=#8aadf4,fg=#181926,bold] SCROLL#[bg=#181926,fg=#8aadf4]"
              mode_enter_search  "#[bg=#8aadf4,fg=#181926,bold] ENT-SEARCH#[bg=#181926,fg=#8aadf4]"
              mode_search    "#[bg=#8aadf4,fg=#181926,bold] SEARCHARCH#[bg=#181926,fg=#8aadf4]"
              mode_rename_tab  "#[bg=#8aadf4,fg=#181926,bold] RENAME-TAB#[bg=#181926,fg=#8aadf4]"
              mode_rename_pane   "#[bg=#8aadf4,fg=#181926,bold] RENAME-PANE#[bg=#181926,fg=#8aadf4]"
              mode_session     "#[bg=#8aadf4,fg=#181926,bold] SESSION#[bg=#181926,fg=#8aadf4]"
              mode_move      "#[bg=#8aadf4,fg=#181926,bold] MOVE#[bg=#181926,fg=#8aadf4]"
              mode_prompt    "#[bg=#8aadf4,fg=#181926,bold] PROMPT#[bg=#181926,fg=#8aadf4]"
              mode_tmux      "#[bg=#f5a97f,fg=#181926,bold] TMUX#[bg=#181926,fg=#f5a97f]"

              // formatting for inactive tabs
              tab_normal        "#[bg=#181926,fg=#8bd5ca]#[bg=#8bd5ca,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#8bd5ca,bold] {name}{floating_indicator}#[bg=#181926,fg=#363a4f,bold]"
              tab_normal_fullscreen   "#[bg=#181926,fg=#8bd5ca]#[bg=#8bd5ca,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#8bd5ca,bold] {name}{fullscreen_indicator}#[bg=#181926,fg=#363a4f,bold]"
              tab_normal_sync     "#[bg=#181926,fg=#8bd5ca]#[bg=#8bd5ca,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#8bd5ca,bold] {name}{sync_indicator}#[bg=#181926,fg=#363a4f,bold]"

              // formatting for the current active tab
              tab_active        "#[bg=#181926,fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#eed49f,bold] {name}{floating_indicator}#[bg=#181926,fg=#363a4f,bold]"
              tab_active_fullscreen   "#[bg=#181926,fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#eed49f,bold] {name}{fullscreen_indicator}#[bg=#181926,fg=#363a4f,bold]"
              tab_active_sync     "#[bg=#181926,fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#eed49f,bold] {name}{sync_indicator}#[bg=#181926,fg=#363a4f,bold]"

              // separator between the tabs
              tab_separator       "#[bg=#181926] "

              // indicators
              tab_sync_indicator     "  "
              tab_fullscreen_indicator " 󰊓"
              tab_floating_indicator   " 󰹙 "

              command_hostname_command   "hostname"
              command_hostname_format    "{stdout}"
              command_hostname_interval  "0"
              command_hostname_rendermode  "static"

              command_username_command   "id -un"
              command_username_format    "{stdout}"
              command_username_interval  "0"
              command_username_rendermode  "static"
            }
          }
          children
          pane size=1 borderless=true {
            plugin location="zjstatus" {
                // You can put `{pipe_zjstatus_hints}` inside of format_left, format_center, or format_right.
                // The pipe name should match the pipe_name configuration option from above, which is zjstatus_hints by default.
                // e.g. pipe_<pipe_name>
                format_right  "{pipe_zjstatus_hints}"

                // Note: this is necessary or else zjstatus won't render the pipe:
                pipe_zjstatus_hints_format "{output}"
            }
          }
        }
      }
    '';
  };
}
