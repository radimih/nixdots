{
  description = "My Nixos configuration flake";

  inputs = {

    # --- nixpkgs

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";  # FIXME: при unstable имеем black screen при логине в tty

    # --- infra

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- soft

    niri.url = "github:sodiboo/niri-flake";

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
