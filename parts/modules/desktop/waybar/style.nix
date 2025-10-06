# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
      window#waybar {
          background: #000000;
      }
      tooltip {
          background: alpha(#000000, 0.5);
      }
    '';

    # Взять из Stylix только определение цветов (baseXX) и шрифта по-умолчанию
    # для всех элементов (stylix.fonts.monospace, stylix.fonts.sizes.desktop)
    stylix.targets.waybar.addCss = false;
  };
}
