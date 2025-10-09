# https://github.com/Alexays/Waybar/wiki/Styling
# Стили по-умолчанию: https://github.com/Alexays/Waybar/blob/master/resources/style.css
{
  flake.modules.homeManager.waybar = {

    # CSS Properties: https://docs.gtk.org/gtk3/css-properties.html

    programs.waybar.style = ''
      @define-color bg-primary #000000;
      @define-color fg-clock-msk #707070;
      @define-color fg-primary #ffffff;
      @define-color fg-title #3498db;

      * {
        border: none;
        border-radius: 0;
        font-family: "RobotoMono Nerd Font Mono";
        font-size: 12pt;
      }

      window#waybar {
        background: @bg-primary;
        color: @fg-primary;
      }
      window#waybar #window {
        color: @fg-title;
      }

      tooltip {
        background: alpha(@bg-primary, 0.8);
      }

      #clock.msk {
        color: @fg-clock-msk;
      }

      #workspaces button {
        border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
        border-bottom: 3px solid @fg-primary;
      }
    '';

    stylix.targets.waybar.enable = false;
  };
}
