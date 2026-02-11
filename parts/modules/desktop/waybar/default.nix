# https://github.com/Alexays/Waybar/wiki
{
  flake.modules.homeManager.waybar = {

    programs.waybar.enable = true;
  };

  flake.modules.homeManager.niri =
    { config, lib, pkgs, ... }:
    {

      programs.niri.settings = {
        spawn-at-startup = [
          { command = [ "waybar" ]; }
          { command = [ "${lib.getExe pkgs.swaybg}" "--image" "${config.stylix.image}" ]; }
        ];
      };
  };
}
