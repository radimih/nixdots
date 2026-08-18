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
          # TODO: next-release: использовать clipse -pause 1s (с версии 1.2), чтобы скриншот всего экрана не попадал в историю буфера обмена
          action.spawn-sh = ''
            ${lib.getExe pkgs.niri} msg action screenshot-screen && sleep 0.5
            ${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image/png | ${lib.getExe pkgs.satty} --filename -
          '';
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
          action.spawn = [ "noctalia" "msg" "panel-toggle" "launcher" ]
          repeat = false;
          hotkey-overlay.title = "Open App Launcher";
        };

        "Mod+V" = {
          action.spawn = [ "${lib.getExe pkgs.xdg-terminal-exec}" "--app-id=clipse" "--" "clipse" ];
          repeat = false;
          hotkey-overlay.title = "Open Clipboard history";
        };
      };
    };
}
