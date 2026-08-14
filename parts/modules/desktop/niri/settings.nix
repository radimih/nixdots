# Niri: https://github.com/niri-wm/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri =
    { config, lib, pkgs, ... }:
    {
      programs.niri.settings = {

        # Отключить при старте вывод подсказки по горячим клавишам. Показать: Mod+Shift+/
        hotkey-overlay.skip-at-startup = true;

        cursor = {
          hide-after-inactive-ms = 5 * 1000;  # 5 секунд
          hide-when-typing = true;
        };

        layout = {
          background-color = "transparent";
          border.width = 2;
          focus-ring.enable = false;
          gaps = 8;
        };

        prefer-no-csd = true;

        # Отключить запись скриншотов на диск
        screenshot-path = null;
      };
    };
}
