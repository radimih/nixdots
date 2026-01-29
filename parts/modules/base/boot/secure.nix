# https://github.com/nix-community/lanzaboote
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

      boot.loader.systemd-boot.enable = lib.mkForce false;

      boot.lanzaboote = {
        enable = true;
        autoEnrollKeys = {
          enable = true;
          autoReboot = true;
        };
        autoGenerateKeys.enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      environment.systemPackages = [
        pkgs.sbctl
      ];
    };
}
