{
  flake.modules.nixos.boot =
    { lib, ...}:
    {
      # Использовать systemd при загрузке с initrd
      boot.initrd.systemd.enable = true;

      # Время в секундах на ожидание выбора поколения NixOS (default = 5)
      boot.loader.timeout = 1;

      # Не ждать при загрузке готовности сети
      systemd.services.NetworkManger-wait-online.wantedBy = lib.mkForce [];
    };
}
