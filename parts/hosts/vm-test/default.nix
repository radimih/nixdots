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
        base
        sound
        user-radimir
        user-test
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

  # --- настройка хоста на уровне Home Manager
  # --- настройки пользователей этого хоста на уровне Home Manager
  # --- настройки пользователей на уровне Home Manager именно для этого хоста

  flake.modules.homeManager.user-radimir =
    { pkgs, ...}:
    {
      imports = with config.flake.modules.homeManager; [
        {
          home.file."host-${host}.txt".text = "${host}";
        }
      ];
    };
}
