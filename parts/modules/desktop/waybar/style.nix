# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
    '';

    stylix.targets.waybar.addCss = true;
  };
}
