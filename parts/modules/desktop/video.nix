{
  flake.modules.nixos.desktop =
    { config, lib, ... }:
    {
      # Добавить всех обычных пользователей в группу video
      users.groups.video.members =
        config.users.users
        |> lib.filterAttrs (key: val: val.isNormalUser)
        |> builtins.attrNames;
    };
}
