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
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.fish;
      };
    };

  # flake.modules.homeManager."user-${user.name}" = {
  # };
}
