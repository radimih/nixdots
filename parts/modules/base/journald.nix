# https://www.freedesktop.org/software/systemd/man/latest/journald.conf.html
{
  flake.modules.nixos.base = {

    # TODO: next-release: services.journald.settings.Journal
    #       https://github.com/NixOS/nixpkgs/pull/536538
    #       services.journald.settings.Journal = {
    #         Storage = "persistent";
    #         SystemMaxUse = "128M";
    #       };
    # Установить максимальный размер системных логов (/var/log/journal/)
    services.journald.extraConfig = "SystemMaxUse=128M";
  };
}
