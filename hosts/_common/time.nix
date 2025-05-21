{
  globalSpec,
  ...
}:

{
  networking.timeServers = [
    "2.nixos.pool.ntp.org"
    "ntp.sstf.nsk.ru"
    "ntp.msk-ix.ru"
  ];

  time.timeZone = globalSpec.timeZone;
}
