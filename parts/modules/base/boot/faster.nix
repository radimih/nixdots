{
  flake.modules.nixos.base =
    { lib, ...}:
    {
      # Время в секундах на ожидание выбора поколения NixOS (default = 5, 0 - не показывать меню)
      boot.loader.timeout = 0;

      # Не ждать при загрузке готовности сети
      systemd.services.NetworkManger-wait-online.wantedBy = lib.mkForce [];
    };
}
