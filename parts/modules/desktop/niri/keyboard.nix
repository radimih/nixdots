# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri =
    { osConfig, ... }:
    {
      programs.niri.settings = {

        binds = {
          # Немодальное переключение раскладки клавиатуры
          # TODO: комбинации клавиш и раскладки клавиатуры сделать через параметры
          "Ctrl+Shift+Mod+F11".action.switch-layout = "0";
          "Ctrl+Shift+Mod+F12".action.switch-layout = "1";
        };

        input.keyboard.xkb.layout = "${osConfig.services.xserver.xkb.layout}";
      };
    };
}
