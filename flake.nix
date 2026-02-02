{
  description = "My Nixos configuration flake";

  inputs = {

    # --- nixpkgs

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # --- Nix/NixOS infra

    agenix = {
      url = "github:ryantm/agenix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
      # ВНИМАНИЕ! Нельзя включать inputs.flake-parts.follows = "flake-parts"; - возникает ошибка о
      # невозможности импортировать agenix-rekey.homeManagerModules.default во flake.modules.homeManager
      # (см. agenix.nix)
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      # url = "git+ssh://git@github.com/radimih/nixdots-secrets.git?shallow=1";
      # flake = false;
      url = "git+ssh://git@github.com/radimih/nixdots-secrets.git?shallow=1";
      inputs = { };
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- software

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- other

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
