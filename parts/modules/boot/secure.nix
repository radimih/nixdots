# https://github.com/nix-community/lanzaboote
{
  flake.modules.nixos.boot-secure =
    { lib, ...}:
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
