# ВНИМАНИЕ! Имя хоста = имя каталога, в котором располагается данный файл
{
  config,
  ...
}:
let
  host = builtins.baseNameOf ./.;
in
{
  flake.modules.nixos."host-${host}" =
    { pkgs, lib, ...}:
    {
      # --- NixOS-параметры хоста

      services = {
        qemuGuest.enable = true;
        spice-vdagentd.enable = true;
        spice-webdavd.enable = true;
      };

      # ---

      imports = with config.flake.modules.nixos; [
        base
        boot-secure
        boot-visual-adi1090x
        desktop
        niri
        service-display-manager-ly
        service-kanata
        user-radimir
        vpn-it2g
      ];

      # --- настройки пользователей на уровне Home Manager на данном хосте

      home-manager.users.radimir.imports = with config.flake.modules.homeManager; [
        base
        desktop
        kitty
        niri
        shell
        waybar
      ] ++ [
        {
          # home.file."hello-host.txt".text = "Привет, radimir! From the ${host} host. Double";
        }
      ];
    };
}
