# Niri: https://github.com/niri-wm/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  inputs,
  ...
}:
{
  flake.modules.nixos.niri =
    { pkgs, ...}:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      # TODO: next-release: в nixpkgs master уже реализовано что-то подобное:
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/wayland/niri.nix
      # ВНИМАНИЕ! Модуль из nixpkgs отключается в niri-flake
      # Настройки ниже не срабатывают: файл /run/current-system/sw/share/xdg-desktop-portal/niri-portals.conf
      # перетирается в https://github.com/sodiboo/niri-flake/blob/main/flake.nix#L192 файлом из пакета pkgs.niri
      xdg.portal = {
        config.niri = {
          default = ["gnome" "gtk"];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
        # BUG: при включении xdg-desktop-portal-gtk перестаёт с первого раза запускаться Waybar
        # extraPortals = with pkgs; [
        #   xdg-desktop-portal-gtk
        # ];
      };
    };

  flake.modules.homeManager.niri =
    {
      programs.niri.settings = {

        environment = {
          # Включить Wayland-режим для приложений:
          DISPLAY = null;
          MOZ_ENABLE_WAYLAND = "1";  # Mozilla-based (Firefox, Zen Browser etc)
          NIXOS_OZONE_WL = "1";  # Ozone-based (Electron)

          # Включить Wayland-режим для распространённых GUI libs:
          # https://wiki.archlinux.org/title/Wayland#GUI_libraries
          CLUTTER_BACKEND = "wayland";
          QT_QPA_PLATFORM = "wayland";
          SDL_VIDEODRIVER = "wayland";

          # Отключить оформление окон Qt-приложений своими средствами. Этим займётся Wayland Compositor
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        };

        # Временно, см. services/network-manager-applet.nix
        spawn-at-startup = [
          { command = ["systemctl" "--user" "restart" "network-manager-applet"]; }
        ];
      };
    };
}
