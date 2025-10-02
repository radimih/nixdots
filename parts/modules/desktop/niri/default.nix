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
        yazi
        waybar
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };
    };

  flake.modules.homeManager.niri =
    { config, lib, osConfig, pkgs, ... }:
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
            # Включить Wayland-режим для приложений:
            MOZ_ENABLE_WAYLAND = "1";  # Mozilla-based (Firefox, Zen Browser etc)
            NIXOS_OZONE_WL = "1";  # Ozone-based (Electron)

            # Включить Wayland-режим для распространённых GUI libs:
            # https://wiki.archlinux.org/title/Wayland#GUI_libraries
            CLUTTER_BACKEND = "wayland";
            GDK_BACKEND = "wayland";
            QT_QPA_PLATFORM = "wayland";
            SDL_VIDEODRIVER = "wayland";

            # Отключить оформление окон Qt-приложений своими средствами. Этим займётся Wayland Compositor
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          };

          input.keyboard.xkb.layout = "${osConfig.services.xserver.xkb.layout}";

	        # Отключить при старте вывод подсказки по горячим клавишам. Показать: Mod+Shift+/
	        hotkey-overlay.skip-at-startup = true;

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

	        window-rules = [
            # Чтобы работала прозрачность (opacity) окон
            # FIXME: возможно ограничить только для kitty
            { draw-border-with-background = false; }
          ];

          spawn-at-startup = [
            { command = ["waybar"]; }
            { command = ["${lib.getExe pkgs.swaybg}" "--image" "${config.stylix.image}"]; }
          ];
        };
      };
    };
}
