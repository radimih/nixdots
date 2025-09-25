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
      opacity.terminal = 0.85;
    };
  };
}
