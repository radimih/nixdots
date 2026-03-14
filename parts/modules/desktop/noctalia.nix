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

        plugins.states = {
          network-manager-vpn = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };

        pluginsSettings = {
          network-manager-vpn = {
            displayMode = "alwaysHide";
          };
        };

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
                  id = "plugin:network-manager-vpn";
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
            compactLockScreen = true;
            lockScreenAnimations = true;
          };

          hooks = {
            enabled = true;
            screenLock = "niri msg action switch-layout 0";
          };

          idle = {
            enabled = true;
            fadeDuration = 5;  # секунд, в течение которых можно прервать действие
            # После указанного количества секунд бездействия пользователя произвести
            # соответствующее действие (0 - не производить данное действие):
            lockTimeout = 10 * 60;
            screenOffTimeout = 0;
            suspendTimeout = 30 * 60;
          };

          location.name = "Kemerovo, Russia";

          notifications = {
            enableKeyboardLayoutToast = false;
            lowUrgencyDuration = 1;
            normalUrgencyDuration = 3;
            criticalUrgencyDuration = 5;
          };

          sessionMenu = {
            enableCountdown = false;
            largeButtonsLayout = "grid";
            powerOptions = [
              { action = "lock"; enabled = true; keybind = "1"; }
              { action = "suspend"; enabled = true; keybind = "2"; }
              { action = "logout"; enabled = true; keybind = "3"; }
              { action = "reboot"; enabled = true; keybind = "4"; }
              { action = "rebootToUefi"; enabled = true; keybind = "5"; }
              { action = "shutdown"; enabled = true; keybind = "6"; }
              { action = "hibernate"; enabled = false; keybind = "7"; }
            ];
          };

          wallpaper.enabled = false;
        };
      };
    };
}
