# Импорты flake-parts
{
  inputs,
  ...
}:
{
  imports = with inputs; [
    # flake-parts.modules: https://flake.parts/options/flake-parts-modules.html
    flake-parts.flakeModules.modules
    # FIXME:
    # # flake-parts.home-manager: https://flake.parts/options/home-manager.html
    # home-manager.flakeModules.home-manager
  ];
}
