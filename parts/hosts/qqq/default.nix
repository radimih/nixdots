
{
  config,
  ...
}:

let
  host = "qqq";
in
{
  flake.modules.nixos."host-${host}" =
    { pkgs, ...}:
    {
      # ---

      imports = with config.flake.modules.nixos; [
        base
        user-test
      ];

      # --- настройки пользователей на уровне Home Manager именно для этого хоста

      home-manager.users.test.imports = with config.flake.modules.homeManager; [
        {
          home.file."host-${host}-test.txt".text = "Hello!";
        }
      ];

      # ---

      boot = {
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
}


