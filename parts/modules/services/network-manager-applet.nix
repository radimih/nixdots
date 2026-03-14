{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      # Чтобы через PATH были доступны все утилиты пакета. Например, nm-connection-editor
      # используется в одном из плагинов Noctalia Shell
      home.packages = [
        pkgs.networkmanagerapplet
      ];

      services = {
        network-manager-applet.enable = true;
      };
    };
}
