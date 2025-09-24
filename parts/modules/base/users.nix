# Общие настройки для всех пользователей
{
  flake.modules.nixos.base = {

    users = {
      mutableUsers = false;
    };
  };
}
