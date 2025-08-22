{
  config,
  inputs,
  lib,
  self,
  ...
}:

{
  flake.nixosConfigurations = {
    vm-test =
      let
        hardConfFile = ../hosts/vm-test/hardware-configuration.nix;
      in
      inputs.nixpkgs.lib.nixosSystem {
        modules = [
          {
            networking.hostName = "vm-test";
            nixpkgs.config.allowUnfree = true;
          }
          config.flake.modules.nixos.host-vm-test
        ] ++ lib.optional (builtins.pathExists hardConfFile) hardConfFile;
        specialArgs = {
          inherit inputs;
          inherit self;
        };
      };
  };
}
