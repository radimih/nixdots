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
        {
          networking.hostName = "vm-test";
          nixpkgs.config.allowUnfree = true;
        }
        # хосты как flake-parts-модули (рабочий вариант)
        # ../hosts/vm-test/hardware-configuration.nix
        config.flake.modules.nixos.host-vm-test
      ];
      specialArgs = {
        inherit inputs;
        inherit self;
      };
    };
  };

}
