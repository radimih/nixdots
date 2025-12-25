# Настройка Vaultix на уровне модуля NixOS: https://milieuim.github.io/vaultix/nixos-option.html
# См. настройку Vaultix на уровне flake: parts/flake/vaultix.nix
{
  inputs,
  ...
}:
{
  flake.modules.nixos.base =
    { config, ... }:
    {
      imports = [ inputs.vaultix.nixosModules.default ];

      services.userborn.enable = true;

      # https://milieuim.github.io/vaultix/option-settings.html
      # vaultix.settings = {
      # };
    };
}
