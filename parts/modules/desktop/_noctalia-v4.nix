# Noctalia: Quickshell based desktop shell: https://github.com/noctalia-dev/noctalia
{
  inputs,
  ...
}:
{
  flake.modules.homeManager.noctalia =
    { lib, pkgs, ... }:
    {
      programs.noctalia-shell = {

        # FIXME: Параметры, котором не найдены аналоги в Noctalia v4

        settings = {
          appLauncher = {
            terminalCommand = "${lib.getExe pkgs.xdg-terminal-exec}";
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
