let
  user = "radimir";
in
{
  flake.modules.nixos."user-${user}" = {
  };

  flake.modules.homeManager."user-${user}" = {
  };
}
