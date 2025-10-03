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
          geometry-corner-radius =
          let
            r = 8.0;
          in
          {
            bottom-left = r;
            bottom-right = r;
            top-left = r;
            top-right = r;
          };
          clip-to-geometry = true;
        }
      ];
    };
  };
}
