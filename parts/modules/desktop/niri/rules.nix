# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri = {

    programs.niri.settings = {

      layer-rules = [
        {
          # Параметры для background-слоя. Название слоя зависит от wallpaper-утилиты.
          # Для swaybg это 'wallpaper'. Посмотреть доступные слои: niri msg layers
          matches = [
            { namespace ="^wallpaper$"; }
          ];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        # Чтобы работала прозрачность (opacity) окон
        # FIXME: возможно ограничить только для kitty
        { draw-border-with-background = false; }

	      # Сделать скруглёнными все углы всех окон
        {
          geometry-corner-radius = {
            bottom-left = 8;
            bottom-right = 8;
            top-left = 8;
            top-right = 8;
          };
          clip-to-geometry = true;
        }
      ];
    };
  };
}
