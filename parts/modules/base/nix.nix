{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Для работы flakes нужен git
      environment.systemPackages = [ pkgs.git ];

      nix.channel.enable = false;

      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "flakes"
          "nix-command"
          "pipe-operators"
        ];
        warn-dirty = false;
      };

      nixpkgs.config.allowUnfree = true;
    };
}
