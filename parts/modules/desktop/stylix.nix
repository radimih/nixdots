# https://nix-community.github.io/stylix/
{
  inputs,
  ...
}:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    let
      # https://github.com/tinted-theming/schemes
      theme = "flat";
    in
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
        cursor = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
          size = 24;
        };
        # cursor = {
        #   name = "Whitesur-cursors";  # https://github.com/vinceliuice/WhiteSur-cursors
        #   package = pkgs.whitesur-cursors;
        #   size = 16;
        # };
        enable = true;
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
        polarity = "dark";
        # Выключить определение стилей для некоторых компонент системы
        targets = {
          console.enable = false;
          plymouth.enable = false;
        };
      };
    };
}
