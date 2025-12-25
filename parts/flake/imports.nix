# Импорты flake-parts
{
  inputs,
  ...
}:
{
  imports = [
    # flake-parts.agenix-rekey: https://flake.parts/options/agenix-rekey.html
    inputs.agenix-rekey.flakeModule
    # flake-parts.modules: https://flake.parts/options/flake-parts-modules.html
    inputs.flake-parts.flakeModules.modules
    # flake-parts.home-manager: https://flake.parts/options/home-manager.html
    # source: https://github.com/nix-community/home-manager/blob/master/flake-module.nix
    inputs.home-manager.flakeModules.home-manager
  ];
}
