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

        # Shift+7 = '?` в раскладке Universal
        "Mod+Shift+7".action.show-hotkey-overlay = { };

        "Mod+A" = {
          action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
          repeat = false;
          hotkey-overlay.title = "App Launcher";
        };

        "Mod+Return" = {
          action.spawn = "${lib.getExe pkgs.xdg-terminal-exec}";
          repeat = false;
          hotkey-overlay.title = "Open a Terminal";
        };
      };
    };
}
