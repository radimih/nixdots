{
  flake.modules.nixos.base = {

    # Список NTP-серверов. По-умолчанию используется как службой
    # systemd-timesyncd, так и службой chronyd

    networking.timeServers = [
      "0.nixos.pool.ntp.org"
      "0.ru.pool.ntp.org"
      "ntp.sstf.nsk.ru"
      "ntp.msk-ix.ru"
    ];

    time.timeZone = "Asia/Novokuznetsk";
  };
}
