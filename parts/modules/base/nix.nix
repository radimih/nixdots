{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Для работы flakes нужен git
      environment.systemPackages = [ pkgs.git ];

      nix = {
        channel.enable = false;
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "flakes"
            "nix-command"
            "pipe-operators"
          ];
          substituters = [
            "https://nix-community.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
          warn-dirty = false;
        };
      };

      nixpkgs.config.allowUnfree = true;
    };
}
