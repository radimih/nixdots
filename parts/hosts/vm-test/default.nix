{
  config,
  ...
}:

let
  # TODO: попробовать считывать имя хоста из файловой системы
  host = "vm-test";
in
{
  flake.modules.nixos."host-${host}" =
    { pkgs, lib, ...}:
    {
      # --- NixOS-параметры хоста

      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.kernelParams = [
      ];

      # ---

      imports = with config.flake.modules.nixos; [
        base
        boot-secure
        boot-visual
        niri
        service-display-manager-ly
        service-kanata
        service-universal-layout
        user-radimir
      ];

      # --- настройки пользователей на уровне Home Manager на данном хосте

      home-manager.users.radimir.imports = with config.flake.modules.homeManager; [
        niri
      ] ++ [
        {
          # home.file."hello-host.txt".text = "Привет, radimir! From the ${host} host. Double";
        }
      ];
    };
}
