# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

          # background: alpha(#000000, 0.5);
    programs.waybar.style = ''
      window#waybar, tooltip {
          background: 0;
      }
    '';

    # Взять из Stylix только определение цветов (baseXX) и шрифта по-умолчанию
    # для всех элементов (stylix.fonts.monospace, stylix.fonts.sizes.desktop)
    stylix.targets.waybar.addCss = false;
  };
}
