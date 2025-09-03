# flake-parts-модуль по настройке Linux-пользователя
{
  config,
  ...
}:
let
  user = {
    name = "radimir";
    desc = "Radimir";
  };
in
{
  # --- добавление пользователя в NixOS и связывание его с Home Manager

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
      };

      home-manager.users.${user.name}.imports = [
        config.flake.modules.homeManager.base
        config.flake.modules.homeManager."user-${user.name}"
      ];
    };

  # --- пользовательские настройки Home Manager для каждого хоста, где устанавливается пользователь

  flake.modules.homeManager."user-${user.name}" =
    { osConfig, ... }:
    let
      host = osConfig.networking.hostName;
    in
    {
      home.file."hello-user.txt".text = "Hello, ${user.name}! host = ${host}.";
    };
}
