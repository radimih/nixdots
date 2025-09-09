# https://nix.dev/manual/nix/stable/command-ref/conf-file.html
{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Для работы flakes нужен git
      environment.systemPackages = [ pkgs.git ];

      # TODO: https://github.com/OkashiOdayakana/nixos-config/blob/main/modules/nixos/core/nix.nix

      # Отключить использование каналов
      nix = {
        channel.enable = false;
        settings.flake-registry = "";
      };

      nix = {
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
          trusted-users = [
            "@wheel"
          ];
          warn-dirty = false;
        };
      };

      nixpkgs.config.allowUnfree = true;

      system.activationScripts = {
        rmChannels = ''
          rm -rf /nix/var/nix/profiles/per-user/root/channels
          rm -rf /root/.nix-channels
        '';
      };

      system.userActivationScripts = {
        rmChannels = ''
          rm -rf $HOME/.nix-defexpr/channels
        '';
      };
    };
}
