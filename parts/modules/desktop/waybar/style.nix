# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
          window#waybar, tooltip {
              background: alpha(@base00, 0.8);
          }
    '';

    stylix.targets.waybar.addCss = false;
  };
}
