{
  globalSpec,
  inputs,
  self,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit globalSpec;
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.${globalSpec.user.name} = import ${self}/users/${globalSpec.user.name}.nix;
}
