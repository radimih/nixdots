# https://github.com/henrysipp/nix-setup/blob/48a93d0275eba0adf48977609fc100dce8f9b49c/modules/flake/host-machines.nix

{
  config,
  inputs,
  lib,
  self,
  ...
}:

{
  flake.nixosConfigurations = {
    vm-test = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ../hosts/vm-test/_hardware-configuration.nix
        config.flake.modules.nixos.host-vm-test
        {
          networking.hostName = "vm-test";
          nixpkgs.config.allowUnfree = true;
        }
      ];
      specialArgs = {
        inherit inputs;
        inherit self;
      };
    };
  };

}
