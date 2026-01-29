# https://search.nixos.org/options?channel=unstable&show=system.stateVersion&query=system.stateVersion
# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
{
  stateVersion,
  ...
}:
{
  flake.modules = {
    nixos.base.system.stateVersion = stateVersion;
    homeManager.base.home.stateVersion = stateVersion;
  };
}
