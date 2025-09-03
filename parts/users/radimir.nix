let
  user = {
    name = "radimir";
    desc = "Radimir";
  };
in
{
  flake.modules.nixos."user-${user.name}" =
    { pkgs, ...}:
    {
      users.users.${user.name} = {
        createHome = true;
        description = user.desc;
        extraGroups = [
          "networkmanager"
          "systemd-journal"
          "wheel"
        ];
        isNormalUser = true;
        shell = pkgs.fish;
      };

      home-manager.users.${user.name}.imports = [
        config.flake.modules.homeManager.base
        config.flake.modules.homeManager.user-radimir
      ];
    };

  flake.modules.homeManager."user-${user.name}" = {

    home.file."user-${user.name}.txt".text = "radimir";
  };
}
