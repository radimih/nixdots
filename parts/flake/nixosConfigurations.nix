{
  config,
  inputs,
  lib,
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
          in
          inputs.nixpkgs.lib.nixosSystem {
            modules = [
              # --- общие настройки для всех хостов
              {
                networking.hostName = host;
                system.stateVersion = "25.05";  # TODO: stateVersion: 1) одинаково для всех хостов? 2) вынести в глобальные константы?
              }
              # --- настройки, специфичные для данного хоста (см. каталог parts/hosts/{host})
              config.flake.modules.nixos."host-${host}"
              # --- hardware-configuration.nix, если он существует
            ] ++ lib.optional (builtins.pathExists hardConfFile) hardConfFile;
            # TODO: specialArgs возможно не нужен
            specialArgs = {
              inherit inputs;
            };
          };
      };
    in
    hosts |> builtins.map mkHost |> builtins.listToAttrs;
}
