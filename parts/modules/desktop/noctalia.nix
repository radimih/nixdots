# Noctalia: native Wayland desktop shell (https://docs.noctalia.dev/)
{
  inputs,
  ...
}:
{
  flake.modules.homeManager.noctalia =
    { lib, pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      # https://docs.noctalia.dev/noctalia/compositor-settings/niri/
      programs.niri.settings = {
        debug = {
          honor-xdg-activation-with-invalid-serial = [];
        };
        spawn-at-startup = [
          { argv = [ "noctalia" ]; }
        ];
        layer-rules = [
          {
            matches = [
              { namespace = "^noctalia-wallpaper"; }
            ];
            place-within-backdrop = true;
          }
        ];
        window-rules = [
          # Floating Noctalia settings window
          {
            matches = [
              { app-id = "dev.noctalia.Noctalia"; }
            ];
            default-column-width.fixed = 1080;
            default-window-height.fixed = 720;
            open-floating = true;
          }
        ];
      };

      programs.noctalia = {
        enable = true;

        settings = {

          bar = {
            order = [ "main" ];
            main = {
              concave_edge_corners = false;
              font_family = "Iosevka Nerd Font Propo";
              margin_ends = 0;
              radius = 0;
              widget_spacing = 8;
              # --- widgets
              start = [
                "launcher"
                "workspaces"
              ];
              center = [
                "active_window"
              ];
              end = [
                "tray"
                "notifications"
                "clipboard"
                "network"
                "bluetooth"
                "battery"
                "control-center"
                "keyboard_layout"
                "group:clocks"
                "session"
              ];
              capsule_group = [
                {
                  id = "clocks";
                  members = [
                    "clock"
                    "clock_moscow"
                  ];
                  enable = true;
                  accordion = false;
                  accordion_direction = "end";
                  border = "";
                  fill = "surface";
                  opacity = 1.0;
                  padding = 6.0;
                  widget_spacing = 5;
                }
              ];
            };
          };

          hooks = {
            # Перед блокировкой экрана переключить раскладку клавиатуры на US
            session_locked = "niri msg action switch-layout 0";
          };

          idle = {
            behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
            behavior = {
              lock = {
                action = "lock";
                enabled = true;
                timeout = 10 * 60; # seconds
              };
              lock-and-suspend = {
                action = "lock_and_suspend";
                enabled = true;
                timeout = 30 * 60; # seconds
              };
              screen-off = {
                action = "screen_off";
                enabled = false;
                timeout = 15 * 60; # seconds
              };
            };
            # Временной отрезок, в течение которого можно прервать действие
            pre_action_fade_seconds = 5;
          };

          location.address = "Kemerovo, Russia";

          lockscreen = {
            blur_intensity = 0.30;
            tint_intensity = 0.30;
          };

          shell = {
            animation.speed = 1.8;
            clipboard_confirm_clear_history = false;
            clipboard_history_max_entries = 50;
            screenshot = {
              confirm_region = true;
              copy_to_clipboard = false;
              pipe_command = "${lib.getExe pkgs.satty} --filename -";
              pipe_to_command = true;
              save_to_file = false;
            };
          };

          theme = {
            mode = "dark";
            pure_black_dark = true;
            source = "wallpaper";
          };

          wallpaper = {
            enabled = true;
            default.path = ./wallpapers/cold-coast-1920x1080.png;
            directory = ./wallpapers;
            fill_mode = "stretch";
            transition = [ "fade" ];
            transition_on_startup = true;
          };

          widget = {
            active_window = {
              max_length = 300;
            };
            clock_moscow = {
              font_weight = 300;
              format = "{:%H}";
              scale = 0.85;
              timezone = "Europe/Moscow";
              type = "clock";
            };
            keyboard_layout = {
              show_glyph = false;
            };
            network = {
              show_label = false;
            };
            session = {
              color = "error";
            };
            tray = {
              hidden = [
                "nm-applet"
              ];
            };
          };
        };
      };
    };
}
