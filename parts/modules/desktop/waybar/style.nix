# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
      window#waybar {
          background: transparent;
      }
    '';

    stylix.targets.waybar.addCss = false;
  };
}
