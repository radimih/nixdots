{
  config,
  ...
}:

let
  host = "vm-test";
in
{
  # --- настройка хоста на уровне NixOS

  flake.modules.nixos."host-${host}" =
    { pkgs, ...}:
    {
      imports = with config.flake.modules.nixos; [
        # --- аспекты
        base
        sound

        # --- пользователи
        user-radimir
        # user-test
      ];

      boot = {
        # kernelPackages = pkgs.linuxPackages_latest;
        kernelParams = [
        ];

        loader = {
          timeout = 0;
          grub = {
            enable = true;
            device = "/dev/vda";
            useOSProber = true;
          };
        };
      };

      environment.systemPackages = with pkgs; [
        vim
      ];
    };

  # --- настройка пользователей хоста на уровне Home Manager

  flake.modules.homeManager.user-radimir =
    { pkgs, ...}:
    {
      imports = with config.flake.modules.homeManager; [
        base
        user-radimir
      ];
    };
}
