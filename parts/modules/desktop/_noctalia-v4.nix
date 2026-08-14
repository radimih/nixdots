# Noctalia: Quickshell based desktop shell: https://github.com/noctalia-dev/noctalia
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

      # https://docs.noctalia.dev/v4/getting-started/compositor-settings/niri/
      programs.niri.settings = {
        debug = {
          honor-xdg-activation-with-invalid-serial = [];
        };
      };

      programs.noctalia-shell = {

        enable = true;
        package = pkgs.noctalia-shell;
        systemd.enable = true;

        # Использовать "родную" тему от Noctalia, вместо темы из Stylix
        colors =
          let
            # Взять из темы цветовую схему dark и убрать цвета для терминала
            # JSON-файлы тем: https://github.com/noctalia-dev/noctalia/tree/legacy-v4/Assets/ColorScheme
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
            sourceUrl = "https://github.com/noctalia-dev/legacy-v4-plugins";
          };
        };

        pluginSettings = {
          network-manager-vpn = {
            displayMode = "alwaysHide";
          };
        };

        settings = {
          appLauncher = {
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

          notifications = {
            enableKeyboardLayoutToast = false;
            lowUrgencyDuration = 1;
            normalUrgencyDuration = 2;
            criticalUrgencyDuration = 4;
          };
        };
      };
    };
}
