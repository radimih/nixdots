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
    hostSettings = {
      name = "vm-test";
      timeZone = "Asia/Novokuznetsk";
    };
    userSettings = {
      name = "radimir";
      desc = "Radimir";
    };
  in {
    nixosConfigurations = {
      ${hostSettings.name} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          # Общие настройки Home Manager
          ({
            home-manager = {
              extraSpecialArgs = {
                inherit userSettings;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          })
          # Настройки Home Manager для отдельных пользователей
          ({
            home-manager.users.${userSettings.name} = import ./home.nix;
          })
        ];
        specialArgs = {
          inherit hostSettings;
          inherit userSettings;
        };
      };
    };
  };
}
