{
  config,
  pkgs,
  globalSpec,
  inputs,
  ...
}:

{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./time.nix
    ./users.nix
  ];

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = globalSpec.stateVersion;
}
