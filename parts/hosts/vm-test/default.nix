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

      imports = with config.flake.modules.nixos; [
        base
        sound
        user-radimir
      ];
  };

  # --- настройка хоста на уровне Home Manager

  flake.modules.homeManager."host-${host}" =
    { pkgs, ...}:
    {
    };
}
