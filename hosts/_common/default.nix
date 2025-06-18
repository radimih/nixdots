{
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

  keyboard.universal-layout.enable = true;
}
