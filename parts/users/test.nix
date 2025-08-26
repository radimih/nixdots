let
  user = {
    name = "test";
    desc = "Test User";
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
          "wheel"
        ];
        initialPassword = "test";
        isNormalUser = true;
        shell = pkgs.bash;
      };
    };

  # flake.modules.homeManager."user-${user.name}" = {
  # };
}
