# https://github.com/Alexays/Waybar/wiki
{
  flake.modules.homeManager.waybar = {

    programs.waybar.enable = true;
  };

  flake.modules.homeManager.niri =
    { config, lib, pkgs, ... }:
    {

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

        spawn-at-startup = [
          { command = [ "waybar" ]; }
          { command = [ "${lib.getExe pkgs.swaybg}" "--image" "${config.stylix.image}" ]; }
        ];
      };
  };
}
