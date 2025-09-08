{
  description = "My Nixos configuration flake";

  nixConfig = {
    extra-experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
  };

  inputs = {

    # --- nixpkgs

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # --- infra

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- software

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- other

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper = {
      url = "path:wallpapers/cold-coast.jpg";
      flake = false;
    };
  };

  outputs =
    {
      flake-parts,
      import-tree,
      nixpkgs,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      notImports = lib.hasSuffix "hardware-configuration.nix";
      flakeParts = (import-tree.filterNot notImports) ./parts;
    in
    flake-parts.lib.mkFlake { inherit inputs; } flakeParts;
}
