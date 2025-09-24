# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
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
        alacritty
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
            "Mod+T" = {
              action.spawn = "alacritty";
              hotkey-overlay.title = "Open a Terminal";
            };
            "Mod+Return" = {
              action.spawn = "kitty";
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
