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
          { command = [ "noctalia" ]; }
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
          };
        };
      };
    };
}
