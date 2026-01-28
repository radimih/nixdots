# Home Manager как NixOS-модуль
# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
{
  inputs,
  ...
}:
{
  # TODO: home-manager refactor
  #       Пример: https://github.com/alex007sirois/nix-config/blob/main/modules/home/home-manager.nix
  #       То есть у пользователя у хоста всегда импортировать base
  flake.modules.nixos.base = {

    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      extraSpecialArgs = {
        secrets = inputs.secrets;
      };
      sharedModules = [
        {
          /*
            Нет необходимости устанавливать параметры home.username|homeDirectory, так как
            Home Manager в режиме NixOS-модуля устанавливает их автоматически:
            https://github.com/nix-community/home-manager/blob/master/nixos/common.nix#L53-L54
          */

          home.preferXdgDirectories = true;

          # example: https://github.com/henrysipp/nix-setup/blob/48a93d0275eba0adf48977609fc100dce8f9b49c/modules/base/system/default.nix
          home.stateVersion = "25.11";  # TODO: stateVersion: 1) одинаково для всех пользователей? 2) вынести в глобальные константы?

          # Let Home Manager install and manage itself
          programs.home-manager.enable = true;
        }
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
