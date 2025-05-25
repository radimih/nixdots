{
  description = "My Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      globalSpec = {
        admin = {
          name = "radimir";
          desc = "Radimir";
        };
        stateVersion = "25.05";
        timeZone = "Asia/Novokuznetsk";
      };
    in
    {
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
              modules = [
                {
                  networking.hostName = host;
                  system.stateVersion = globalSpec.stateVersion;
                }
                ./hosts/${host}
              ];
              specialArgs = {
                inherit globalSpec;
                inherit inputs;
                inherit self;
              };
            };
          };
        in
        hosts |> map mkHost |> builtins.listToAttrs;
    };
}
