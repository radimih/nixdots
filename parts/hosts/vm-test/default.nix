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
        kitty  # FIXME: next-release: убрать, когда xdg.terminal-exec появится в home-manager
        niri
        service-display-manager-ly
        service-kanata
        service-universal-layout
        user-radimir
      ];

      # --- настройки пользователей на уровне Home Manager на данном хосте

      home-manager.users.radimir.imports = with config.flake.modules.homeManager; [
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
