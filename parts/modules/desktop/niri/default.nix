# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
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

      environment.systemPackages = with pkgs; [
        fuzzel
        yazi
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      xdg.portal = {
        config.niri = {
          default = ["gnome" "gtk"];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
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
      };
    };
}
