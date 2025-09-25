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
    theme = "atlas";
  in
  {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
      enable = true;
      # opacity.terminal = 0.8;
      # Выключить определение стилей для некоторых компонент системы
      targets = {
        console.enable = false;
        # kitty.variant256Colors = true;
        plymouth.enable = false;
      };
    };
  };
}
