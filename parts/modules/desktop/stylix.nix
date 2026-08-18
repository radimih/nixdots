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
        base16Scheme = "${pkgs.base16-schemes}/share/themes/blueish.yaml";
        override = {
          base08 = "F7768E";  # цвет error: зелёный поменять на красный (взят из темы Tokyo Night by Noctalia)
          base0B = "4CE587";  # цвет text: жёлтый поменять на зелёный
        };

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
