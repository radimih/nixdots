{
  globalSpec,
  ...
}:

{
  networking.timeServers = [
    "0.nixos.pool.ntp.org"
    "0.ru.pool.ntp.org"
    "ntp.sstf.nsk.ru"
    "ntp.msk-ix.ru"
  ];

  time.timeZone = globalSpec.timeZone;
}
