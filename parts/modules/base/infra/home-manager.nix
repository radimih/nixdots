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

          # Let Home Manager install and manage itself
          programs.home-manager.enable = true;
        }
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
