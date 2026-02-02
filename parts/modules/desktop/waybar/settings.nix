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
          "tray"
          "niri/language"
          "clock#local"
          "clock#msk"
        ];

	      "niri/language" = {
          format = "{short}";
          # format-En = "English";
          # format-Ru = "Русский";
          on-click = "niri msg action switch-layout next";
        };

        "clock#local" = {
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_down";
            on-scroll-down = "shift_up";
          };
          format = "{:%H:%M}";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "";
            on-scroll = 1;
            format = {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          tooltip-format = "<tt>{calendar}</tt>";
        };

        "clock#msk" = {
          format = "<sub>{:%H} MSK</sub>";
          timezone = "Europe/Moscow";
          tooltip-format = "Московское время: {:%H:%M}";
        };
      };
    };
  };
}
