{
  description = "My Nixos configuration flake";

  nixConfig = {
    accept-flake-config = true;
    extra-experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {

    # --- nixpkgs

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # --- Nix/NixOS infra

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      # рекомендуют сами разработчики lanzaboote (см. https://github.com/nix-community/lanzaboote/blob/master/flake.nix)
      inputs.pre-commit-hooks-nix.follows = "";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- software

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- other

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
