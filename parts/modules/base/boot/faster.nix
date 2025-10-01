{
  flake.modules.nixos.base =
    { lib, ...}:
    {
      # Использовать systemd при загрузке с initrd
      # TODO: в 25.11 планируется сделать по-умолчанию: https://github.com/NixOS/nixpkgs/pull/435781
      boot.initrd.systemd.enable = true;

      # Время в секундах на ожидание выбора поколения NixOS (default = 5)
      boot.loader.timeout = 1;

      # Не ждать при загрузке готовности сети
      systemd.services.NetworkManger-wait-online.wantedBy = lib.mkForce [];
    };
}
