# https://nix-community.github.io/stylix/
{
  inputs,
  ...
}:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {

        enable = true;

        # https://github.com/tinted-theming/schemes
        # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";

        # https://github.com/ful1e5/Bibata_Cursor
        cursor = {
          name = "Bibata-Original-Classic";
          package = pkgs.bibata-cursors;
          size = 24;
        };

        # Просмотр шрифтов в Kitty: kitten choose-fonts
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.iosevka;
            name = "IosevkaNFM";  # -Thin, -ExtraLight, -Light, [-Regular],-Medium (NFM - Nerd Font Mono)
          };
          sizes = {
            applications = 12;
            desktop = 11;
            popups = 11;
            terminal = 12;
          };
        };

        image = ./wallpapers/cold-coast-1920x1080.png;

        opacity = {
          desktop = 0.93;
          popups = 1.0;
          terminal = 0.8;
        };

        polarity = "dark";

        # Выключить определение стилей для некоторых компонент системы
        targets = {
          console.enable = false;
          plymouth.enable = false;
        };
      };
    };
}
