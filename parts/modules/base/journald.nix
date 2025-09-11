# https://www.freedesktop.org/software/systemd/man/latest/journald.conf.html
{
  flake.modules.nixos.base = {

    # Установить максимальный размер системных логов (/var/log/journal/)
    services.journald.extraConfig = "SystemMaxUse=128M";
  };
}
