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
          in
          inputs.nixpkgs.lib.nixosSystem {
          modules = [
            config.flake.modules.nixos.host-${host}
            {
              networking.hostName = host;
              system.stateVersion = "25.05";  # TODO: stateVersion: 1) одинаково для всех хостов? 2) вынести в глобальные константы?
            }
          ] ++ lib.optional (builtins.pathExists hardConfFile) hardConfFile;
          specialArgs = {
            inherit inputs;
            inherit self;
          };
        };
      };
    in
    hosts |> builtins.map mkHost |> builtins.listToAttrs;
}
