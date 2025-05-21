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
    ./users.nix
  ];

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = globalSpec.stateVersion;

  time.timeZone = globalSpec.timeZone;
}
