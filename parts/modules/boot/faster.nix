{
  flake.modules.nixos.boot =
    { lib, ...}:
    {
      # Использовать systemd при загрузке с initrd
      boot.initrd.systemd.enable = true;

      # Время в секундах на ожидание выбора поколения NixOS (default = 5)
      boot.loader.timeout = 1;

      # Настроить консоль как можно раньше, для initrd (например, если для консоли переопределяется шрифт)
      console.earlySetup = true;

      # Не ждать при загрузке готовности сети
      systemd.services.NetworkManger-wait-online.wantedBy = lib.mkForce [];
    };
}
