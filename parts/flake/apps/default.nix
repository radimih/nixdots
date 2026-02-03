{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      apps.rekey = import ./rekey.nix inputs pkgs;
    };
}
