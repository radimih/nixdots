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
            };
          };

          hooks = {
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
                timeout = 11 * 60; # seconds
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
            keyboard_layout = {
              show_glyph = false;
            };
            session = {
              color = "error";
            };
          };
        };
      };
    };
}
