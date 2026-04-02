{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      system.activationScripts = {

        # Выводить после команд nixos-rebuild switch/dry-activate какие пакеты изменились
        diff = {
          supportsDryActivation = true;
          # https://github.com/faukah/dix
          text = ''
            ${pkgs.dix}/bin/dix /run/current-system "$systemConfig"
          '';
        };
      };
    };
}
