{
  flake.modules.nixos.base =
    { lib, ...}:
    {
      # Использовать systemd при загрузке с initrd
      # TODO: next-release: планируется сделать по-умолчанию: https://github.com/NixOS/nixpkgs/pull/435781
      boot.initrd.systemd.enable = true;

      # Время в секундах на ожидание выбора поколения NixOS (default = 5, 0 - не показывать меню)
      boot.loader.timeout = 0;

      # Не ждать при загрузке готовности сети
      systemd.services.NetworkManger-wait-online.wantedBy = lib.mkForce [];
    };
}
