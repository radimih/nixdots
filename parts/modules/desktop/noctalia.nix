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
        systemd.enable = true;

        settings = {
          settingsVersion = 1;
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

          wallpaper.enabled = false;
        };
      };
    };
}
