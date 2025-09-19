{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      system.activationScripts = {

	    # Выводить после команд nixos-rebuild switch/dry-activate какие пакеты изменились
        diff = {
          supportsDryActivation = true;
          # TODO: перейти на https://github.com/faukah/dix когда появится в stable-версии NixOS
          text = ''
            ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
          '';
        };
      };

      system.rebuild.enableNg = true;
    };
}
