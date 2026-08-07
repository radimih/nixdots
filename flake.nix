{
  description = "My Nixos configuration flake";

  inputs = {

    # --- nixpkgs

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # --- Nix/NixOS infra

    agenix = {
      url = "github:ryantm/agenix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
      # BUG: Нельзя включать inputs.flake-parts.follows = "flake-parts"; - возникает ошибка о
      # невозможности импортировать agenix-rekey.homeManagerModules.default во flake.modules.homeManager
      # (см. agenix.nix)
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      # FIXME: lanzaboote: не попадает в кэш, если установлен follows.
      #        При этом время сборки системы увеличивается на 5 минут,
      #        а /nix/store увеличивается на 3,8 Гб.
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    secrets = {
      url = "git+ssh://git@github.com/radimih/nixdots-secrets.git?shallow=1";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- software

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia?ref=v4.7.6";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "nixpkgs";
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
