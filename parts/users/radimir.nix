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
    };

  # flake.modules.homeManager."user-${user.name}" = {
  # };
}
