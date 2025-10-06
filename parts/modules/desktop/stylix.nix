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
        base16Scheme = "${pkgs.base16-schemes}/share/themes/flat.yaml";

        # https://github.com/ful1e5/Bibata_Cursor
        cursor = {
          name = "Bibata-Modern-Classic";
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
            desktop = 10;
            popups = 10;
            terminal = 12;
          };
        };

        image = ./wallpapers/cold-coast.jpg;

        opacity = {
          desktop = 0.8;
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
