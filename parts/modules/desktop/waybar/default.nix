# https://github.com/Alexays/Waybar/wiki
{
  flake.modules.homeManager.waybar = {

    programs.waybar.enable = true;
  };

  flake.modules.homeManager.niri = {

    programs.niri.settings = {
      spawn-at-startup = [
        { command = [ "waybar" ]; }
      ];
    };
  };
}
