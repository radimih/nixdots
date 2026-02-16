# https://docs.noctalia.dev/
{
  inputs,
  ...
}:
{
  flake.modules.homeManager.noctalia =
    { pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia-shell = {
        enable = true;

        bar = {
          left = [
            {
              id = "Workspace";
            }
          ];
          center = [
            {
              id = "ActiveWindow";
              maxWidth = 200;
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "ControlCenter";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "KeyboardLayout";
              showIcon = false;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
            }
            {
              id = "SessionMenu";
            }
          ];
        };

        desktopWidgets.enabled = false;

        dock.enabled = false;

        hooks.screenLock = "niri msg action switch-layout 0";

        location.name = "Kemerovo";

        notifications = {
          enableKeyboardLayoutToast = false;
        };

        sessionMenu = {
          enableCountdown = false;
          largeButtonsLayout = "grid";
        };

        systemd.enable = true;

        wallpaper.enabled = false;
      };
    };
}
