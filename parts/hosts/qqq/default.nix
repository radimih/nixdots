{
  config,
  ...
}:

let
  host = "qqq";
in
{
  # --- настройка хоста на уровне NixOS

  flake.modules.nixos."host-${host}" =
    { pkgs, ...}:
    {
      imports = with config.flake.modules.nixos; [
        base
        user-radimir
        # user-test
      ];

      boot = {
        kernelParams = [
          "qqq"
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
