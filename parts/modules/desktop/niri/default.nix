# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  inputs,
  config,
  ...
}:
{
  flake.modules.nixos.niri =
    { pkgs, ...}:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      environment.systemPackages = with pkgs; [
        fuzzel
        waybar
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };
    };

  flake.modules.homeManager.niri =
    { lib, osConfig, pkgs, ... }:
    let
      defaultKeyBinds = import ./_defaultKeyBinds.nix;
    in
    {
      programs.niri = {
        settings = {

          binds = defaultKeyBinds // {
            # Немодальное переключение раскладки клавиатуры
            # TODO: комбинации клавиш и раскладки клавиатуры сделать через параметры
            "Ctrl+Shift+Mod+F11".action.switch-layout = "0";
            "Ctrl+Shift+Mod+F12".action.switch-layout = "1";
            "Mod+D" = {
              action.spawn = "fuzzel";
              hotkey-overlay.title = "Run an Application";
            };
            "Mod+Return" = {
              action.spawn = "kitty";
              repeat = false;
              hotkey-overlay.title = "Open a Terminal";
            };
          };

          environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
            NIXOS_OZONE_WL = "1";
          };

          input.keyboard.xkb.layout = "${osConfig.services.xserver.xkb.layout}";

	        layer-rules = [
            {
              # Параметры для background-слоя. Название слоя зависит от wallpaper-утилиты.
              # Для swaybg это 'wallpaper'. Посмотреть доступные слои: niri msg layers
              matches = [
                { namespace ="^wallpaper$"; }
              ];
              place-within-backdrop = true;
            }
          ];

          layout = {
            background-color = "transparent";
          };

          # outputs.Virtual-1 = {
          #   background-color = "transparent";
          # };

          spawn-at-startup = [
            { command = ["waybar"]; }
            { command = ["${lib.getExe pkgs.swaybg}" "--image" "${inputs.wallpaper}"]; }
          ];
        };
      };
    };
}
