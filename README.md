# Alice's Dot Files

## Bootstraping

Follow [this guide in the manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual), up to and including `nixos-generate-config`  
Once it instructs you to edit `configuration.nix`, run

```bash
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME

# Or if you'd like to edit the config before installing
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME -d -c # To download and copy in the hardware config
# Edit away
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME -i # To finish the install

# Or to disable copying hardware config
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME -d -i

# Or to quickly setup a VM
sudo sh -c "$(curl -fsLS jacka.net.au/dotfiles)" -- HOSTNAME --vm
```

```
Usage: bootstrap.sh [options] hostname

Options:
  -d, --download    Clone the dotfiles to /mnt. Implies -n
  -u, --upgrade     Update flake.lock to the latest versions before installing
  -c, --copy        Copying hardware config. Implies -n
  -i, --install     Install with the flake as input. Implies -n
  -e, --everything  Implied unless other switches are passed. Download, copy and install. Equivilent to '-d -c -i'
  -n, --nothing     Require explicitly enabling any steps you want
  --vm              Quickly setup from within a VM. Partition vda, generate hardware config, and mount virtiofs dotfiles if available
  --user username   Set the username for the user to create. YOU NEED TO UPDATE CONFIGURATION.NIX TO CREATE THE USER
```

## Reloading Config

```
Usage: reload [options] [new-hostname]

Options:
  -u, --upgrade     Add pull updates from upstream and update lockfile
  -t, --show-trace  Pass --show-trace to rebuild command (for debuggin)
  -P, --pull        Pull updates from git before updating
```

### TODO

- codium
- hyprpolkitagent
- hardware.cpu.amd.updateMicrocode
- bluetooth
- check https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/ works
- check screenshots work

- https://keyboard.frame.work https://community.frame.work/t/responded-help-configuring-fw16-keyboard-with-via/47176/5
- wl-clip-persist
- hyprpaper
- eslint
- btrbk

- fingerprint
  - Hyprlock
  - Regreet
  - sudo
  - polkit
- fastfetch
- minecraft

- Reload script
  - update schedule
  - cleanup
  - git actions
  - dry run
  - better param parsing

## Resources

[NixOS Package Search](https://search.nixos.org/packages)
[Nüschtos Options Search](https://search.n%C3%BCschtos.de)
[JSON to Nix](https://json-to-nix.pages.dev/)

## Zellij

### Layout

```
layout {
  pane size=1 borderless=true {
    plugin location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" {
      // -- Catppuccin Mocha --
      color_rosewater "#f5e0dc"
      color_flamingo "#f2cdcd"
      color_pink "#f5c2e7"
      color_mauve "#cba6f7"
      color_red "#f38ba8"
      color_maroon "#eba0ac"
      color_peach "#fab387"
      color_yellow "#f9e2af"
      color_green "#a6e3a1"
      color_teal "#94e2d5"
      color_sky "#89dceb"
      color_sapphire "#74c7ec"
      color_blue "#89b4fa"
      color_lavender "#b4befe"
      color_text "#cdd6f4"
      color_subtext1 "#bac2de"
      color_subtext0 "#a6adc8"
      color_overlay2 "#9399b2"
      color_overlay1 "#7f849c"
      color_overlay0 "#6c7086"
      color_surface2 "#585b70"
      color_surface1 "#45475a"
      color_surface0 "#313244"
      color_base "#1e1e2e"
      color_mantle "#181825"
      color_crust "#11111b"

      // -- Catppuccin Latte --
      //color_rosewater "#dc8a78"
      //color_flamingo "#dd7878"
      //color_pink "#ea76cb"
      //color_mauve "#8839ef"
      //color_red "#d20f39"
      //color_maroon "#e64553"
      //color_peach "#fe640b"
      //color_yellow "#df8e1d"
      //color_green "#40a02b"
      //color_teal "#179299"
      //color_sky "#04a5e5"
      //color_sapphire "#209fb5"
      //color_blue "#1e66f5"
      //color_lavender "#7287fd"
      //color_text "#4c4f69"
      //color_subtext1 "#5c5f77"
      //color_subtext0 "#6c6f85"
      //color_overlay2 "#7c7f93"
      //color_overlay1 "#8c8fa1"
      //color_overlay0 "#9ca0b0"
      //color_surface2 "#acb0be"
      //color_surface1 "#bcc0cc"
      //color_surface0 "#ccd0da"
      //color_base "#eff1f5"
      //color_mantle "#e6e9ef"
      //color_crust "#dce0e8"

      // -- Catppuccin Frappé --
      //color_rosewater "#f2d5cf"
      //color_flamingo "#eebebe"
      //color_pink "#f4b8e4"
      //color_mauve "#ca9ee6"
      //color_red "#e78284"
      //color_maroon "#ea999c"
      //color_peach "#ef9f76"
      //color_yellow "#e5c890"
      //color_green "#a6d189"
      //color_teal "#81c8be"
      //color_sky "#99d1db"
      //color_sapphire "#85c1dc"
      //color_blue "#8caaee"
      //color_lavender "#babbf1"
      //color_text "#c6d0f5"
      //color_subtext1 "#b5bfe2"
      //color_subtext0 "#a5adce"
      //color_overlay2 "#949cbb"
      //color_overlay1 "#838ba7"
      //color_overlay0 "#737994"
      //color_surface2 "#626880"
      //color_surface1 "#51576d"
      //color_surface0 "#414559"
      //color_base "#303446"
      //color_mantle "#292c3c"
      //color_crust "#232634"

      // -- Catppuccin Macchiato --
      //color_rosewater "#f4dbd6"
      //color_flamingo "#f0c6c6"
      //color_pink "#f5bde6"
      //color_mauve "#c6a0f6"
      //color_red "#ed8796"
      //color_maroon "#ee99a0"
      //color_peach "#f5a97f"
      //color_yellow "#eed49f"
      //color_green "#a6da95"
      //color_teal "#8bd5ca"
      //color_sky "#91d7e3"
      //color_sapphire "#7dc4e4"
      //color_blue "#8aadf4"
      //color_lavender "#b7bdf8"
      //color_text "#cad3f5"
      //color_subtext1 "#b8c0e0"
      //color_subtext0 "#a5adcb"
      //color_overlay2 "#939ab7"
      //color_overlay1 "#8087a2"
      //color_overlay0 "#6e738d"
      //color_surface2 "#5b6078"
      //color_surface1 "#494d64"
      //color_surface0 "#363a4f"
      //color_base "#24273a"
      //color_mantle "#1e2030"
      //color_crust "#181926"

      format_left   "#[bg=$surface0,fg=$sapphire]#[bg=$sapphire,fg=$crust,bold] {session} #[bg=$surface0] {mode}#[bg=$surface0] {tabs}"
      format_center "{notifications}"
      format_right  "#[bg=$surface0,fg=$flamingo]#[fg=$crust,bg=$flamingo] #[bg=$surface1,fg=$flamingo,bold] {command_user}@{command_host}#[bg=$surface0,fg=$surface1]#[bg=$surface0,fg=$maroon]#[bg=$maroon,fg=$crust]󰃭 #[bg=$surface1,fg=$maroon,bold] {datetime}#[bg=$surface0,fg=$surface1]"
      format_space  "#[bg=$surface0]"
      format_hide_on_overlength "true"
      format_precedence "lrc"

      border_enabled  "false"
      border_char     "─"
      border_format   "#[bg=$surface0]{char}"
      border_position "top"

      hide_frame_for_single_pane "true"

      mode_normal        "#[bg=$green,fg=$crust,bold] NORMAL#[bg=$surface0,fg=$green]"
      mode_tmux          "#[bg=$mauve,fg=$crust,bold] TMUX#[bg=$surface0,fg=$mauve]"
      mode_locked        "#[bg=$red,fg=$crust,bold] LOCKED#[bg=$surface0,fg=$red]"
      mode_pane          "#[bg=$teal,fg=$crust,bold] PANE#[bg=$surface0,fg=teal]"
      mode_tab           "#[bg=$teal,fg=$crust,bold] TAB#[bg=$surface0,fg=$teal]"
      mode_scroll        "#[bg=$flamingo,fg=$crust,bold] SCROLL#[bg=$surface0,fg=$flamingo]"
      mode_enter_search  "#[bg=$flamingo,fg=$crust,bold] ENT-SEARCH#[bg=$surfaco,fg=$flamingo]"
      mode_search        "#[bg=$flamingo,fg=$crust,bold] SEARCHARCH#[bg=$surfac0,fg=$flamingo]"
      mode_resize        "#[bg=$yellow,fg=$crust,bold] RESIZE#[bg=$surfac0,fg=$yellow]"
      mode_rename_tab    "#[bg=$yellow,fg=$crust,bold] RENAME-TAB#[bg=$surface0,fg=$yellow]"
      mode_rename_pane   "#[bg=$yellow,fg=$crust,bold] RENAME-PANE#[bg=$surface0,fg=$yellow]"
      mode_move          "#[bg=$yellow,fg=$crust,bold] MOVE#[bg=$surface0,fg=$yellow]"
      mode_session       "#[bg=$pink,fg=$crust,bold] SESSION#[bg=$surface0,fg=$pink]"
      mode_prompt        "#[bg=$pink,fg=$crust,bold] PROMPT#[bg=$surface0,fg=$pink]"

      tab_normal              "#[bg=$surface0,fg=$blue]#[bg=$blue,fg=$crust,bold]{index} #[bg=$surface1,fg=$blue,bold] {name}{floating_indicator}#[bg=$surface0,fg=$surface1]"
      tab_normal_fullscreen   "#[bg=$surface0,fg=$blue]#[bg=$blue,fg=$crust,bold]{index} #[bg=$surface1,fg=$blue,bold] {name}{fullscreen_indicator}#[bg=$surface0,fg=$surface1]"
      tab_normal_sync         "#[bg=$surface0,fg=$blue]#[bg=$blue,fg=$crust,bold]{index} #[bg=$surface1,fg=$blue,bold] {name}{sync_indicator}#[bg=$surface0,fg=$surface1]"
      tab_active              "#[bg=$surface0,fg=$peach]#[bg=$peach,fg=$crust,bold]{index} #[bg=$surface1,fg=$peach,bold] {name}{floating_indicator}#[bg=$surface0,fg=$surface1]"
      tab_active_fullscreen   "#[bg=$surface0,fg=$peach]#[bg=$peach,fg=$crust,bold]{index} #[bg=$surface1,fg=$peach,bold] {name}{fullscreen_indicator}#[bg=$surface0,fg=$surface1]"
      tab_active_sync         "#[bg=$surface0,fg=$peach]#[bg=$peach,fg=$crust,bold]{index} #[bg=$surface1,fg=$peach,bold] {name}{sync_indicator}#[bg=$surface0,fg=$surface1]"
      tab_separator           "#[bg=$surface0] "

      tab_sync_indicator       " "
      tab_fullscreen_indicator " 󰊓"
      tab_floating_indicator   " 󰹙"

      notification_format_unread "#[bg=surface0,fg=$yellow]#[bg=$yellow,fg=$crust] #[bg=$surface1,fg=$yellow] {message}#[bg=$surface0,fg=$yellow]"
      notification_format_no_notifications ""
      notification_show_interval "10"

      command_host_command    "uname -n"
      command_host_format     "{stdout}"
      command_host_interval   "0"
      command_host_rendermode "static"

      command_user_command    "whoami"
      command_user_format     "{stdout}"
      command_user_interval   "10"
      command_user_rendermode "static"

      datetime          "{format}"
      datetime_format   "%Y-%m-%d 󰅐 %H:%M"
      datetime_timezone "Australia/Melbourne"
    }
  }
  pane
  pane size=2 borderless=true {
    plugin location="status-bar"
  }
}
```

### config

```
// If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
keybinds clear-defaults=true {
    normal {
        // uncomment this and adjust key if using copy_on_select=false
        bind "Alt c" { Copy; }
    }
    locked {
        bind "Ctrl g" { SwitchToMode "Normal"; }
    }
    resize {
        bind "Ctrl n" { SwitchToMode "Normal"; }
        bind "h" "Left" { Resize "Increase Left"; }
        bind "j" "Down" { Resize "Increase Down"; }
        bind "k" "Up" { Resize "Increase Up"; }
        bind "l" "Right" { Resize "Increase Right"; }
        bind "H" { Resize "Decrease Left"; }
        bind "J" { Resize "Decrease Down"; }
        bind "K" { Resize "Decrease Up"; }
        bind "L" { Resize "Decrease Right"; }
        bind "=" "+" { Resize "Increase"; }
        bind "-" { Resize "Decrease"; }
    }
    pane {
        bind "Ctrl p" { SwitchToMode "Normal"; }
        bind "h" "Left" { MoveFocus "Left"; }
        bind "l" "Right" { MoveFocus "Right"; }
        bind "j" "Down" { MoveFocus "Down"; }
        bind "k" "Up" { MoveFocus "Up"; }
        bind "p" { SwitchFocus; }
        bind "n" { NewPane; SwitchToMode "Normal"; }
        bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
        bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
        bind "x" { CloseFocus; SwitchToMode "Normal"; }
        bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
        bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
        bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
        bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
        bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
    }
    move {
        bind "Ctrl h" { SwitchToMode "Normal"; }
        bind "n" "Tab" { MovePane; }
        bind "p" { MovePaneBackwards; }
        bind "h" "Left" { MovePane "Left"; }
        bind "j" "Down" { MovePane "Down"; }
        bind "k" "Up" { MovePane "Up"; }
        bind "l" "Right" { MovePane "Right"; }
    }
    tab {
        bind "Ctrl t" { SwitchToMode "Normal"; }
        bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
        bind "h" "Left" "Up" "k" { GoToPreviousTab; }
        bind "l" "Right" "Down" "j" { GoToNextTab; }
        bind "n" { NewTab; SwitchToMode "Normal"; }
        bind "x" { CloseTab; SwitchToMode "Normal"; }
        bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
        bind "b" { BreakPane; SwitchToMode "Normal"; }
        bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
        bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
        bind "1" { GoToTab 1; SwitchToMode "Normal"; }
        bind "2" { GoToTab 2; SwitchToMode "Normal"; }
        bind "3" { GoToTab 3; SwitchToMode "Normal"; }
        bind "4" { GoToTab 4; SwitchToMode "Normal"; }
        bind "5" { GoToTab 5; SwitchToMode "Normal"; }
        bind "6" { GoToTab 6; SwitchToMode "Normal"; }
        bind "7" { GoToTab 7; SwitchToMode "Normal"; }
        bind "8" { GoToTab 8; SwitchToMode "Normal"; }
        bind "9" { GoToTab 9; SwitchToMode "Normal"; }
        bind "Tab" { ToggleTab; }
    }
    scroll {
        bind "Ctrl s" { SwitchToMode "Normal"; }
        bind "e" { EditScrollback; SwitchToMode "Normal"; }
        bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
        bind "j" "Down" { ScrollDown; }
        bind "k" "Up" { ScrollUp; }
        bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
        bind "d" { HalfPageScrollDown; }
        bind "u" { HalfPageScrollUp; }
        // uncomment this and adjust key if using copy_on_select=false
        // bind "Alt c" { Copy; }
    }
    search {
        bind "Ctrl s" { SwitchToMode "Normal"; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
        bind "j" "Down" { ScrollDown; }
        bind "k" "Up" { ScrollUp; }
        bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
        bind "d" { HalfPageScrollDown; }
        bind "u" { HalfPageScrollUp; }
        bind "n" { Search "down"; }
        bind "p" { Search "up"; }
        bind "c" { SearchToggleOption "CaseSensitivity"; }
        bind "w" { SearchToggleOption "Wrap"; }
        bind "o" { SearchToggleOption "WholeWord"; }
    }
    entersearch {
        bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
        bind "Enter" { SwitchToMode "Search"; }
    }
    renametab {
        bind "Ctrl c" { SwitchToMode "Normal"; }
        bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
    }
    renamepane {
        bind "Ctrl c" { SwitchToMode "Normal"; }
        bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
    }
    session {
        bind "Ctrl o" { SwitchToMode "Normal"; }
        bind "Ctrl s" { SwitchToMode "Scroll"; }
        bind "d" { Detach; }
        bind "w" {
            LaunchOrFocusPlugin "session-manager" {
                floating true
                move_to_focused_tab true
            };
            SwitchToMode "Normal"
        }
    }
    tmux {
        bind "[" { SwitchToMode "Scroll"; }
        bind "Ctrl b" { Write 2; SwitchToMode "Normal"; }
        bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
        bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
        bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
        bind "c" { NewTab; SwitchToMode "Normal"; }
        bind "," { SwitchToMode "RenameTab"; }
        bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
        bind "n" { GoToNextTab; SwitchToMode "Normal"; }
        bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
        bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
        bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
        bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
        bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
        bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
        bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
        bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
        bind "o" { FocusNextPane; }
        bind "d" { Detach; }
        bind "Space" { NextSwapLayout; }
        bind "x" { CloseFocus; SwitchToMode "Normal"; }
    }
    shared_except "locked" {
        bind "Ctrl g" { SwitchToMode "Locked"; }
        bind "Ctrl q" { Quit; }
        bind "Alt n" { NewPane; }
        bind "Alt i" { MoveTab "Left"; }
        bind "Alt o" { MoveTab "Right"; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "Alt [" { PreviousSwapLayout; }
        bind "Alt ]" { NextSwapLayout; }
    }
    shared_except "normal" "locked" {
        bind "Enter" "Esc" { SwitchToMode "Normal"; }
    }
    shared_except "pane" "locked" {
        bind "Ctrl p" { SwitchToMode "Pane"; }
    }
    shared_except "resize" "locked" {
        bind "Ctrl n" { SwitchToMode "Resize"; }
    }
    shared_except "scroll" "locked" {
        bind "Ctrl s" { SwitchToMode "Scroll"; }
    }
    shared_except "session" "locked" {
        bind "Ctrl o" { SwitchToMode "Session"; }
    }
    shared_except "tab" "locked" {
        bind "Ctrl t" { SwitchToMode "Tab"; }
    }
    shared_except "move" "locked" {
        bind "Ctrl h" { SwitchToMode "Move"; }
    }
    shared_except "tmux" "locked" {
        bind "Ctrl b" { SwitchToMode "Tmux"; }
    }
    shared_except "locked" {
        bind "Ctrl y" {
            LaunchOrFocusPlugin "file:~/zellij-plugins/zellij_forgot.wasm" {
                "lock"                  "ctrl + g"
                "unlock"                "ctrl + g"
                "new pane"              "ctrl + p + n"
                "change focus of pane"  "ctrl + p + arrow key"
                "close pane"            "ctrl + p + x"
                "rename pane"           "ctrl + p + c"
                "toggle fullscreen"     "ctrl + p + f"
                "toggle floating pane"  "ctrl + p + w"
                "toggle embed pane"     "ctrl + p + e"
                "choose right pane"     "ctrl + p + l"
                "choose left pane"      "ctrl + p + r"
                "choose upper pane"     "ctrl + p + k"
                "choose lower pane"     "ctrl + p + j"
                "new tab"               "ctrl + t + n"
                "close tab"             "ctrl + t + x"
                "change focus of tab"   "ctrl + t + arrow key"
                "rename tab"            "ctrl + t + r"
                "sync tab"              "ctrl + t + s"
                "brake pane to new tab" "ctrl + t + b"
                "brake pane left"       "ctrl + t + ["
                "brake pane right"      "ctrl + t + ]"
                "toggle tab"            "ctrl + t + tab"
                "increase pane size"    "ctrl + n + +"
                "decrease pane size"    "ctrl + n + -"
                "increase pane top"     "ctrl + n + k"
                "increase pane right"   "ctrl + n + l"
                "increase pane bottom"  "ctrl + n + j"
                "increase pane left"    "ctrl + n + h"
                "decrease pane top"     "ctrl + n + K"
                "decrease pane right"   "ctrl + n + L"
                "decrease pane bottom"  "ctrl + n + J"
                "decrease pane left"    "ctrl + n + H"
                "move pane to top"      "ctrl + h + k"
                "move pane to right"    "ctrl + h + l"
                "move pane to bottom"   "ctrl + h + j"
                "move pane to left"     "ctrl + h + h"
                "search"                "ctrl + s + s"
                "go into edit mode"     "ctrl + s + e"
                "detach session"        "ctrl + o + w"
                "open session manager"  "ctrl + o + w"
                "quit zellij"           "ctrl + q"
                floating true
            }
        }
    }
}

plugins {
    tab-bar location="zellij:tab-bar"
    status-bar location="zellij:status-bar"
    strider location="zellij:strider"
    compact-bar location="zellij:compact-bar"
    session-manager location="zellij:session-manager"
    welcome-screen location="zellij:session-manager" {
        welcome_screen true
    }
    filepicker location="zellij:strider" {
        cwd "/"
    }
}

// Choose what to do when zellij receives SIGTERM, SIGINT, SIGQUIT or SIGHUP
// eg. when terminal window with an active zellij session is closed
// Options:
//   - detach (Default)
//   - quit
//
// on_force_close "quit"

//  Send a request for a simplified ui (without arrow fonts) to plugins
//  Options:
//    - true
//    - false (Default)
//
// simplified_ui true

// Choose the path to the default shell that zellij will use for opening new panes
// Default: $SHELL
//
// default_shell "fish"

// Choose the path to override cwd that zellij will use for opening new panes
//
// default_cwd ""

// Toggle between having pane frames around the panes
// Options:
//   - true (default)
//   - false
//
// pane_frames true

// Toggle between having Zellij lay out panes according to a predefined set of layouts whenever possible
// Options:
//   - true (default)
//   - false
//
// auto_layout true

// Whether sessions should be serialized to the cache folder (including their tabs/panes, cwds and running commands) so that they can later be resurrected
// Options:
//   - true (default)
//   - false
//
session_serialization true

// Whether pane viewports are serialized along with the session, default is false
// Options:
//   - true
//   - false (default)
serialize_pane_viewport true

// Scrollback lines to serialize along with the pane viewport when serializing sessions, 0
// defaults to the scrollback size. If this number is higher than the scrollback size, it will
// also default to the scrollback size. This does nothing if `serialize_pane_viewport` is not true.
//
scrollback_lines_to_serialize 10000

// Define color themes for Zellij
// For more examples, see: https://github.com/zellij-org/zellij/tree/main/example/themes
// Once these themes are defined, one of them should to be selected in the "theme" section of this file
//
// themes {
//     dracula {
//         fg 248 248 242
//         bg 40 42 54
//         red 255 85 85
//         green 80 250 123
//         yellow 241 250 140
//         blue 98 114 164
//         magenta 255 121 198
//         orange 255 184 108
//         cyan 139 233 253
//         black 0 0 0
//         white 255 255 255
//     }
// }

// Choose the theme that is specified in the themes section.
// Default: default
//
// theme "default"

// The name of the default layout to load on startup
// Default: "default"
//
default_layout "/home/alice/.config/zellij/aliceLayout.kdl"

// Choose the mode that zellij uses when starting up.
// Default: normal
//
// default_mode "locked"

// Toggle enabling the mouse mode.
// On certain configurations, or terminals this could
// potentially interfere with copying text.
// Options:
//   - true (default)
//   - false
//
// mouse_mode false

// Configure the scroll back buffer size
// This is the number of lines zellij stores for each pane in the scroll back
// buffer. Excess number of lines are discarded in a FIFO fashion.
// Valid values: positive integers
// Default value: 10000
//
// scroll_buffer_size 10000

// Provide a command to execute when copying text. The text will be piped to
// the stdin of the program to perform the copy. This can be used with
// terminal emulators which do not support the OSC 52 ANSI control sequence
// that will be used by default if this option is not set.
// Examples:
//
// copy_command "xclip -selection clipboard" // x11
// copy_command "wl-copy"                    // wayland
// copy_command "pbcopy"                     // osx

// Choose the destination for copied text
// Allows using the primary selection buffer (on x11/wayland) instead of the system clipboard.
// Does not apply when using copy_command.
// Options:
//   - system (default)
//   - primary
//
// copy_clipboard "primary"

// Enable or disable automatic copy (and clear) of selection when releasing mouse
// Default: true
//
copy_on_select false

// Path to the default editor to use to edit pane scrollbuffer
// Default: $EDITOR or $VISUAL
//
// scrollback_editor "/usr/bin/vim"

// When attaching to an existing session with other users,
// should the session be mirrored (true)
// or should each user have their own cursor (false)
// Default: false
//
// mirror_session true

// The folder in which Zellij will look for layouts
//
// layout_dir "~/.config/zellij/"

// The folder in which Zellij will look for themes
//
// theme_dir "/path/to/my/theme_dir"

// Enable or disable the rendering of styled and colored underlines (undercurl).
// May need to be disabled for certain unsupported terminals
// Default: true
//
// styled_underlines false

// Enable or disable writing of session metadata to disk (if disabled, other sessions might not know
// metadata info on this session)
// Default: false
//
// disable_session_metadata true

ui {
  pane_frames {
    rounded_corners true
  }
}
```
