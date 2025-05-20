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

  # Let home Manager install and manage itself
  programs.home-manager.enable = true;

  home-manager.users.${globalSpec.admin.name} = import "${self}/users/${globalSpec.admin.name}.nix";
}
