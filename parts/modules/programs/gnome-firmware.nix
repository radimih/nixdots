# GUI над fwupd: обновление прошивок оборудования
# https://gitlab.gnome.org/World/gnome-firmware
{
  flake.modules.nixos.desktop =
    { pkgs, ...}:
    {
      environment.systemPackages = [
        pkgs.gnome-firmware
      ];
    };
}
