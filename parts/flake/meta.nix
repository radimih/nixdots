{
  lib,
  ...
}:
{
  options.flake.meta = lib.mkOption {
    type = with lib.types; lazyAttrsOf anything;
  };
}
# TODO: пример использования: https://github.com/LilDojd/rhizome/blob/master/modules/meta/owner.nix
#                             https://github.com/LilDojd/rhizome/blob/master/modules/git/defaults.nix
