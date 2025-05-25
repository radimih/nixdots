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
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./time.nix
    ./users.nix
  ];
}
