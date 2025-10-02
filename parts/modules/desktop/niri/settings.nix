# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri =
    { config, lib, pkgs, ... }:
    {
      programs.niri.settings = {

        # Отключить при старте вывод подсказки по горячим клавишам. Показать: Mod+Shift+/
        hotkey-overlay.skip-at-startup = true;

        layout = {
          background-color = "transparent";
        };

        prefer-no-csd = true;

        spawn-at-startup = [
          { command = [ "waybar" ]; }
          { command = [ "${lib.getExe pkgs.swaybg}" "--image" "${config.stylix.image}" ]; }
        ];
      };
    };
}
