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
    globalSpec = {
      timeZone = "Asia/Novokuznetsk";
      user = {
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
                inherit globalSpec;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          })
          # Настройки Home Manager для отдельных пользователей
          ({
            home-manager.users.${globalSpec.user.name} = import ./home.nix;
          })
        ];
        specialArgs = {
          inherit globalSpec;
        };
      };
    };
  };
}
