{
  description = "Minimal Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
        timeZone = "Asia/Novokuznetsk";
        user = {
          name = "radimir";
          desc = "Radimir";
        };
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
                { networking.hostName = host; }
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
