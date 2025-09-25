{
  inputs,
  ...
}:
{
  flake.modules.nixos.desktop =
  { pkgs, ... }:
  let
    theme = "solarized-dark";
  in
  {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
      enable = true;
      opacity.terminal = 0.85;
    };
  };
}
