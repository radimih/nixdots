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
    nixosConfigurations =
      let
        hosts =
          let
            entries = builtins.readDir ./hosts;
          in
          entries
          |> builtins.attrNames
          |> builtins.filter (file: entries.${file} == "directory")
          |> builtins.filter (file: file != "_common");

        mkHost = host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/${host}
              { networking.hostName = host; }
              home-manager.nixosModules.home-manager
              # Общие настройки Home Manager
              {
                home-manager = {
                  extraSpecialArgs = {
                    inherit globalSpec;
                    inherit inputs;
                  };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                };
              }
              # Настройки Home Manager для отдельных пользователей
              { home-manager.users.${globalSpec.user.name} = import ./home.nix; }
            ];
            specialArgs = {
              inherit globalSpec;
              inherit inputs;
            };
          };
        };
      in
      hosts |> map mkHost |> builtins.listToAttrs;
  };
}
