# Общие настройки для всех пользователей
{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      users = {
        # defaultUserShell = pkgs.fish;
        mutableUsers = false;
      };
    };
}
