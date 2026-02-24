# Noctalia: Quickshell based desktop shell: https://github.com/noctalia-dev/noctalia-shell
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

      # https://docs.noctalia.dev/getting-started/compositor-settings/niri/
      programs.niri.settings = {
        debug = {
          honor-xdg-activation-with-invalid-serial = [];
        };
      };

      programs.noctalia-shell = {

        enable = true;
        systemd.enable = true;

        # Использовать "родную" тему от Noctalia, вместо темы из Stylix
        colors =
          let
            # Взять из темы цветовую схему dark и убрать цвета для терминала
            # JSON-файлы тем: https://github.com/noctalia-dev/noctalia-shell/tree/main/Assets/ColorScheme
            colorsTheme =
              builtins.readFile "${inputs.noctalia.outPath}/Assets/ColorScheme/Tokyo-Night/Tokyo-Night.json"
              |> builtins.fromJSON
              |> (attrs: attrs.dark)
              |> (attrs: builtins.removeAttrs attrs ["terminal"]);
          in
          lib.mkForce colorsTheme;

        settings = {
          appLauncher = {
            enableSettingsSearch = false;
            terminalCommand = "${lib.getExe pkgs.xdg-terminal-exec}";
          };

          bar = {
            widgets = {
              left = [
                {
                  id = "Workspace";
                }
              ];
              center = [
                {
                  id = "ActiveWindow";
                  maxWidth = 300;
                }
              ];
              right = [
                {
                  id = "Tray";
                  blacklist = [
                    "nm-applet"
                  ];
                }
                {
                  id = "VPN";
                }
                {
                  id = "NotificationHistory";
                }
                {
                  id = "ControlCenter";
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

          general = {
            animationDisabled = false;
            animationSpeed = 1.8;
          };

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
