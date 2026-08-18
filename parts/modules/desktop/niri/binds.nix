# Niri: https://github.com/niri-wm/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri =
    { lib, pkgs, ... }:
    let
      defaultKeyBinds = import ./_defaultKeyBinds.nix;
    in
    {
      programs.niri.settings.binds = defaultKeyBinds // {

        "Print" = {
          action.spawn = [ "noctalia" "msg" "screenshot-region" ];
          repeat = false;
        };

        "Mod+Return" = {
          action.spawn = "${lib.getExe pkgs.xdg-terminal-exec}";
          repeat = false;
          hotkey-overlay.title = "Open Terminal";
        };

        # Shift+7 = '?` в раскладке Universal
        "Mod+Shift+7".action.show-hotkey-overlay = { };

        "Mod+A" = {
          action.spawn = [ "noctalia" "msg" "panel-toggle" "launcher" ];
          repeat = false;
          hotkey-overlay.title = "Open Noctalia App Launcher";
        };

        "Mod+V" = {
          action.spawn = [ "noctalia" "msg" "panel-toggle" "clipboard" ];
          repeat = false;
          hotkey-overlay.title = "Open Noctalia Clipboard history";
        };
      };
    };
}
