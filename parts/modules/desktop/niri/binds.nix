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

        "Mod+Return" = {
          action.spawn = "${lib.getExe pkgs.xdg-terminal-exec}";
          repeat = false;
          hotkey-overlay.title = "Open a Terminal";
        };
      };
    };
}
