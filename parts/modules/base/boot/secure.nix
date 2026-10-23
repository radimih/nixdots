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

      # TODO: Lanzaboote 1.2: включить Measured Boot
      #       Ограничение: допустимы только 4 поколения (systemd-boot.configurationLimit),
      #       пока не разрешится
      #         issue https://github.com/systemd/systemd/issues/41526
      #         (PR https://github.com/systemd/systemd/pull/43982)
      #       Docs:
      #         https://nix-community.github.io/lanzaboote/explanation/measured-boot.html
      #         https://nix-community.github.io/lanzaboote/how-to-guides/enable-measured-boot.html
      #
      #       Не забыть изменить parts/flake/apps/tpm2.sh
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
