# Home Manager как NixOS-модуль
# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module

{
  inputs,
  config,
  ...
}:

{
  flake.modules.nixos.base = {

    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      # backupFileExtension = "backup";  # TODO: проверить, будет ли ошибка, если файлы уже существуют: https://github.com/nix-community/home-manager/blob/master/nixos/common.nix#L84
      extraSpecialArgs = {
        inherit inputs;
      };
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    # home-manager.users.radimir.imports = [
    #   {
    #     home.stateVersion = "25.05";  # TODO: stateVersion: 1) одинаково для всех пользователей? 2) вынести в глобальные константы?
    #     programs.home-manager.enable = true;
    #   }
    #   # config.flake.modules.homeManager."host-${config.flake.meta.host}"
    #   config.flake.modules.homeManager.host-vm-test
    #   config.flake.modules.homeManager.user-radimir
    #   # config.flake.modules.homeManager.base
    # ];
  };

  flake.modules.homeManager.base = {

    /*
      Нет необходимости устанавливать параметры home.username|homeDirectory, так как
      Home Manager в режиме NixOS-модуля устанавливает их автоматически:
      https://github.com/nix-community/home-manager/blob/master/nixos/common.nix#L53-L54
    */

    home.stateVersion = "25.05";  # TODO: stateVersion: 1) одинаково для всех пользователей? 2) вынести в глобальные константы?

    # Let home Manager install and manage itself
    programs.home-manager.enable = true;

    # TODO: https://home-manager-options.extranix.com/?query=autoExpire&release=release-25.05
    # services = {
    #   home-manager.autoExpire = {
    #     enable = true;
    #     frequency = "weekly";
    #     store.cleanup = true;
    #   };
    # };
  };
}
