{
  config,
  pkgs,
  globalSpec,
  inputs,
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

  # TODO: путь к файлу сделать более универсальным
  home-manager.users.${globalSpec.user.name} = import ./../../users/${globalSpec.user.name}.nix;
}
