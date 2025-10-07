# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
      * {
        font-family: "RobotoMono Nerd Font Mono";
        font-size: 12pt;
      }
      window#waybar {
        background: #000000;
      }
      tooltip {
        background: alpha(#000000, 0.8);
      }
      #clock.msk {
        color: #707070;
      }
      #workspaces button.focused {
        color: #e2c43c;
      }
    '';

    stylix.targets.waybar.enable = false;
  };
}
