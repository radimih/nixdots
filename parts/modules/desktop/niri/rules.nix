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
	      # Сделать скруглёнными все углы всех окон
        {
          geometry-corner-radius = {
            bottom-left = 8.0;
            bottom-right = 8.0;
            top-left = 8.0;
            top-right = 8.0;
          };
          clip-to-geometry = true;
        }
      ];
    };
  };
}
