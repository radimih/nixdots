{
  description = "Minimal Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    userSettings = {
      name = "radimir";
      desc = "Radimir";
    };
  in {
    nixosConfigurations = {
      vm-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userSettings.name} = import ./home.nix;
            home-manager.extraSpecialArgs = {
              inherit userSettings;
            };
          }
        ];
        specialArgs = {
          inherit userSettings;
        }
      };
    };
  };
}
