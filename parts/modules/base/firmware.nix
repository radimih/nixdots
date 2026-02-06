# fwupd: https://github.com/fwupd/fwupd
{
  flake.modules.nixos.base = {

    hardware.enableAllFirmware = true;
    services.fwupd.enable = true;
  };
}
