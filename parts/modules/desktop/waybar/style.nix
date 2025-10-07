# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.homeManager.waybar = {

    # CSS Properties: https://docs.gtk.org/gtk3/css-properties.html

    programs.waybar.style = ''
      @define-color fg-color-primary #ffffff;

      * {
        font-family: "RobotoMono Nerd Font Mono";
        font-size: 12pt;
      }

      window#waybar {
        background: #000000;
      }
      window#waybar #window {
        color: #3498db;
      }

      tooltip {
        background: alpha(#000000, 0.8);
      }

      #clock.msk {
        color: #707070;
      }

      #workspaces button {
        border-radius: 0;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
        border-radius: 0;
        border-bottom: 3px solid @fg-color-primary;
      }
    '';

    stylix.targets.waybar.enable = false;
  };
}
