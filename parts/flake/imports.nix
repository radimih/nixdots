# Импорты flake-parts
{
  inputs,
  ...
}:
{
  imports = with inputs; [
    # flake-parts.modules: https://flake.parts/options/flake-parts-modules.html
    flake-parts.flakeModules.modules
    # flake-parts.home-manager: https://flake.parts/options/home-manager.html
    # source: https://github.com/nix-community/home-manager/blob/master/flake-module.nix
    home-manager.flakeModules.home-manager
  ];
}
