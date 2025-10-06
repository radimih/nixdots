# https://github.com/Alexays/Waybar/wiki/Configuration
{
  flake.modules.homeManager.waybar = {

    programs.waybar.settings = {

      mainBar = {
        # ─────────────────────────────────────────────────────────┤ General │
        layer = "top";
        position = "top";
        spacing = 6;

        # ─────────────────────────────────────────────────────────┤ Left │
        modules-left = [
          "niri/workspaces"
        ];

        "niri/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        # ─────────────────────────────────────────────────────────┤ Center │
        modules-center = [
          "niri/window"
        ];

        # ─────────────────────────────────────────────────────────┤ Right │
        modules-right = [
          "niri/language"
          "clock#local"
          "clock#msk"
        ];

	      "niri/language" = {
          format = "{short}";
        };

        "clock#msk" = {
          format = "/ {:%H} MSK";
          timezone = "Europe/Moscow";
        };
      };
    };
  };
}
