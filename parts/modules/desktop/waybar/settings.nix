# https://github.com/Alexays/Waybar/wiki/Configuration
{
  flake.modules.homeManager.waybar = {

    programs.waybar.settings = {

      mainBar = {
        layer = "top";
        # position = "top";
        spacing = 6;

        modules-left = [
          "niri/workspaces"
        ];

        modules-center = [
          "niri/window"
        ];

        modules-right = [
        ];

        "niri/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
      };
    };
  };
}
