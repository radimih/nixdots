# https://docs.noctalia.dev/
{
  inputs,
  ...
}:
{
  flake.modules.homeManager.noctalia =
    { lib, pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;

        settings = {
          appLauncher = {
            enableSettingsSearch = false;
            terminalCommand = "${lib.getExe pkgs.xdg-terminal-exec}";
          };

          bar = {
            widgets = {
              left = [
                {
                  id = "Launcher";
                }
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
          };

          desktopWidgets.enabled = false;

          dock.enabled = false;

          hooks = {
            enabled = true;
            screenLock = "niri msg action switch-layout 0";
          };

          location.name = "Kemerovo, Russia";

          notifications = {
            enableKeyboardLayoutToast = false;
          };

          sessionMenu = {
            enableCountdown = false;
            largeButtonsLayout = "grid";
          };

          wallpaper.enabled = false;
        };
      };
    };
}
