# Home Manager как NixOS-модуль
# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
{
  inputs,
  ...
}:
{
  flake.modules.nixos.base = {

    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    # https://nix-community.github.io/home-manager/nixos-options.xhtml

    home-manager = {
      extraSpecialArgs = {
        secrets = inputs.secrets;
      };
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  flake.modules.homeManager.base = {

    # https://nix-community.github.io/home-manager/options.xhtml

    /*
      Нет необходимости устанавливать параметры home.username|homeDirectory, так как
      Home Manager в режиме NixOS-модуля устанавливает их автоматически:
      https://github.com/nix-community/home-manager/blob/master/nixos/common.nix#L53-L54
    */

    home.preferXdgDirectories = true;
    programs.home-manager.enable = true;

    services = {
      home-manager.autoExpire = {
        enable = true;
        frequency = "weekly";
        store.cleanup = false;  # не запускать nix-collect-garbage. Его запуск настраивается в ./nix.nix
        timestamp = "-3 days";  # удалять поколения Home Manager (generations) старше 3-х дней
      };
    };
  };
}
