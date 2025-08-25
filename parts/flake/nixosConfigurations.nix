{
  config,
  inputs,
  lib,
  self,
  ...
}:

{
  flake.nixosConfigurations =
    let
      hosts =
        let
          entries = builtins.readDir ../hosts;
        in
        entries
        |> builtins.attrNames
        |> builtins.filter (file: entries.${file} == "directory");

      mkHost = host: {
        name = host;
        value =
          let
            hardConfFile = ../hosts/${host}/hardware-configuration.nix;
            specialArgs = {
              inherit inputs;
              inherit self;
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              # --- общие настройки хоста
              {
                networking.hostName = host;
                system.stateVersion = "25.05";  # TODO: stateVersion: 1) одинаково для всех хостов? 2) вынести в глобальные константы?
              }
              # --- Home Manager как NixOS-модуль
              inputs.home-manager.nixosModules.home-manager
              # --- настройки Home Manager
              {
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
              # ---
              config.flake.modules.nixos."host-${host}"
              # --- hardware-configuration.nix, если он существует
            ] ++ lib.optional (builtins.pathExists hardConfFile) hardConfFile;
          };
      };
    in
    hosts |> builtins.map mkHost |> builtins.listToAttrs;
}
