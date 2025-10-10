# https://github.com/nix-community/lanzaboote
# TODO: next-release: посмотреть в сторону boot.loader.limine.secureBoot.enable
{
  inputs,
  ...
}:
{
  flake.modules.nixos.boot-secure =
    { lib, pkgs, ...}:
    {
      imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
      ];

      boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };

      environment.systemPackages = [
        pkgs.sbctl
      ];

    };
}
