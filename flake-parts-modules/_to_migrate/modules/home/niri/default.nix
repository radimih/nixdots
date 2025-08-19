{
  config,
  osConfig,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.home.niri;
  defaultKeyBinds = import ./defaultKeyBinds.nix;
in
{
  options.modules.home.niri = {

    enable = lib.mkEnableOption "Scrollable-tiling Wayland compositor";

  };

  config = lib.mkIf cfg.enable {

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
          "Mod+T" = {
            action.spawn = "alacritty";
            hotkey-overlay.title = "Open a Terminal";
          };
        };

        environment = {
          DISPLAY = ":0";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          NIXOS_OZONE_WL = "1";
          XDG_CURRENT_DESKTOP = "niri";
          XDG_SESSION_DESKTOP = "niri";
          XDG_SESSION_TYPE = "wayland";
        };

        input.keyboard.xkb.layout = "${osConfig.services.xserver.xkb.layout}";

        spawn-at-startup = [
          { command = ["waybar"]; }
          { command = ["${lib.getExe pkgs.swaybg}" "--image" "${inputs.wallpaper}"]; }
        ];
      };
    };
  };
}
