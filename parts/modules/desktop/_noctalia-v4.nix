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
