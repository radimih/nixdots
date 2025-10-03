# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
          window#waybar, tooltip {
              background: alpha(#2c3e50, 0.8);
          }
    '';

    stylix.targets.waybar.addCss = false;
  };
}
