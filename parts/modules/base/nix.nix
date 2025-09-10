# https://nix.dev/manual/nix/stable/command-ref/conf-file.html
{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Для работы flakes нужен git
      environment.systemPackages = [ pkgs.git ];

      # Отключить использование каналов
      nix.channel.enable = false;

      nix.settings = {
        auto-optimise-store = true;

        # Отключить все глобальные flake registry (https://channels.nixos.org/flake-registry.json).
        # Останется только один системный nixpkgs, привязанный к inputs.nixpkgs (nix registry list)
        flake-registry = "";

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

      nixpkgs.config.allowUnfree = true;

      # Даже при отключенных каналах (nix.channel.enable = false) остаются файлы, связанные
      # с каналами (см. описание опции nix.channel.enable). Чтобы команда nixos-rebuild switch
      # перестала выводить об этом предупреждающие сообщения, необходимо удалить эти файлы

      system.activationScripts = {
        rmChannels = ''
          rm -rf /nix/var/nix/profiles/per-user/root/channels
          rm -rf /root/.nix-channels
          rm -rf /root/.nix-defexpr/channels
        '';
      };

      system.userActivationScripts = {
        rmChannels = ''
          rm -rf $HOME/.nix-defexpr/channels
        '';
      };
    };
}
