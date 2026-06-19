{
  pkgs,
  ...
}:

{
  programs.zellij = {
    enable = true;
    plugins = with pkgs.zellijPlugins; [
      zjstatus
    ];

    settings = {
      show_startup_tips = false;
    };

    layouts = {
      default = {
        layout = {
          _children = [
            {
              default_tab_template = {
                _children = [
                  {
                    pane = {
                      _props = {
                        size = 1;
                        borderless = true;
                      };
                      plugin = {
                        _props = {
                          location = "zjstatus";
                        };
                        _children = [
                          {
                            format_left = "{mode}#[bg=#181926] {tabs}";
                            format_center = "";

                            format_right = "{swap_layout} #[bg=#181926,fg=##777777] {command_username}@{command_hostname}: {session}";
                            format_space = "#[bg=#181926]";
                            format_hide_on_overlength = false;
                            format_precedence = "crl";

                            border_enabled = true;
                            border_char = "─";
                            border_format = "#[fg=#6C7086]{char}";
                            border_position = "top";

                            # hide_frame_for_single_pane = true; # TODO https://github.com/dj95/zjstatus/issues/174

                            mode_normal = "#[bg=#a6da95,fg=#181926,bold] NORMAL#[bg=#181926,fg=#a6da95]";
                            mode_locked = "#[bg=#6e738d,fg=#181926,bold] LOCKED  #[bg=#181926,fg=#6e738d]";
                            mode_resize = "#[bg=#8aadf4,fg=#181926,bold] RESIZE#[bg=#181926,fg=#8aadf4]";
                            mode_pane = "#[bg=#8aadf4,fg=#181926,bold] PANE#[bg=#181926,fg=#8aadf4]";
                            mode_tab = "#[bg=#8aadf4,fg=#181926,bold] TAB#[bg=#181926,fg=#8aadf4]";
                            mode_scroll = "#[bg=#8aadf4,fg=#181926,bold] SCROLL#[bg=#181926,fg=#8aadf4]";
                            mode_enter_search = "#[bg=#8aadf4,fg=#181926,bold] ENT-SEARCH#[bg=#181926,fg=#8aadf4]";
                            mode_search = "#[bg=#8aadf4,fg=#181926,bold] SEARCHARCH#[bg=#181926,fg=#8aadf4]";
                            mode_rename_tab = "#[bg=#8aadf4,fg=#181926,bold] RENAME-TAB#[bg=#181926,fg=#8aadf4]";
                            mode_rename_pane = "#[bg=#8aadf4,fg=#181926,bold] RENAME-PANE#[bg=#181926,fg=#8aadf4]";
                            mode_session = "#[bg=#8aadf4,fg=#181926,bold] SESSION#[bg=#181926,fg=#8aadf4]";
                            mode_move = "#[bg=#8aadf4,fg=#181926,bold] MOVE#[bg=#181926,fg=#8aadf4]";
                            mode_prompt = "#[bg=#8aadf4,fg=#181926,bold] PROMPT#[bg=#181926,fg=#8aadf4]";
                            mode_tmux = "#[bg=#f5a97f,fg=#181926,bold] TMUX#[bg=#181926,fg=#f5a97f]";

                            # formatting for inactive tabs
                            tab_normal = "#[bg=#181926,fg=#8bd5ca]#[bg=#8bd5ca,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#8bd5ca,bold] {name}{floating_indicator}#[bg=#181926,fg=#363a4f,bold]";
                            tab_normal_fullscreen = "#[bg=#181926,fg=#8bd5ca]#[bg=#8bd5ca,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#8bd5ca,bold] {name}{fullscreen_indicator}#[bg=#181926,fg=#363a4f,bold]";
                            tab_normal_sync = "#[bg=#181926,fg=#8bd5ca]#[bg=#8bd5ca,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#8bd5ca,bold] {name}{sync_indicator}#[bg=#181926,fg=#363a4f,bold]";

                            # formatting for the current active tab
                            tab_active = "#[bg=#181926,fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#eed49f,bold] {name}{floating_indicator}#[bg=#181926,fg=#363a4f,bold]";
                            tab_active_fullscreen = "#[bg=#181926,fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#eed49f,bold] {name}{fullscreen_indicator}#[bg=#181926,fg=#363a4f,bold]";
                            tab_active_sync = "#[bg=#181926,fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#363a4f,fg=#eed49f,bold] {name}{sync_indicator}#[bg=#181926,fg=#363a4f,bold]";

                            # separator between the tabs
                            tab_separator = "#[bg=#181926] ";

                            # indicators
                            tab_sync_indicator = "  ";
                            tab_fullscreen_indicator = " 󰊓";
                            tab_floating_indicator = " 󰹙 ";

                            command_hostname_command = "hostname";
                            command_hostname_format = "{stdout}";
                            command_hostname_interval = "0";
                            command_hostname_rendermode = "static";

                            command_username_command = "id -un";
                            command_username_format = "{stdout}";
                            command_username_interval = "0";
                            command_username_rendermode = "static";
                          }
                        ];
                      };
                    };
                  }
                  {
                    children = { };
                  }
                  {
                    pane = {
                      borderless = true;
                      plugin = {
                        location = "zellij:status-bar";
                      };
                      size = 1;
                    };
                  }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
