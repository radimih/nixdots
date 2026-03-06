# Niri: https://github.com/niri-wm/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri = {

    programs.niri.settings = {

      window-rules = [

	      # У всех окон скруглены все углы
        {
          geometry-corner-radius =
          let
            r = 10.0;
          in
          {
            bottom-left = r;
            bottom-right = r;
            top-left = r;
            top-right = r;
          };
          clip-to-geometry = true;
        }

        # Все floating-окна с тенями
        {
          matches = [
            { is-floating = true; }
          ];
          shadow.enable = true;
        }

        # Размер и расположение окна истории буфера обмена
        {
          matches = [
            { app-id = "^clipse$"; }
          ];
          default-floating-position = {
            x = 0;
            y = 20;
            relative-to = "top";
          };
          default-column-width.proportion = 0.4;
          default-window-height.proportion = 0.6;
          opacity = 1.0;
          open-floating = true;
        }
      ];
    };
  };
}
