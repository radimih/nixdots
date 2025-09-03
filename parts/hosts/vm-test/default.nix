{
  config,
  ...
}:

let
  host = "vm-test";
in
{
  flake.modules.nixos."host-${host}" =
    { pkgs, ...}:
    {
      # ---

      imports = with config.flake.modules.nixos; [
        base
        user-radimir
        user-test
      ];

      # --- настройки пользователей на уровне Home Manager именно для этого хоста

      home-manager.users.radimir.imports = with config.flake.modules.homeManager; [
        {
          home.file."host-${host}-radimir.txt".text = "Hello!";
        }
      ];

      home-manager.users.test.imports = with config.flake.modules.homeManager; [
        {
          home.file."host-${host}-test.txt".text = "Hello!";
        }
      ];

      # ---

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
    };
}
