{
  flake.modules.nixos.build-diff =
    { pkgs, ...}:
    {
      system.activationScripts = {

	      # Выводить после команд nixos-rebuild switch / dry-activate какие пакеты изменились
        diff = {
          supportsDryActivation = true;
          text = ''
            ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
          '';
        };
      };
    };
}
