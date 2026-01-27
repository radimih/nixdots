# flake-parts-модуль по настройке Linux-пользователя
topLevel:
let
  user = {
    name = "demo";
    desc = "Demo user";
  };
in
{
  # --- добавление пользователя в NixOS и связывание его с Home Manager

  flake.modules.nixos."user-${user.name}" =
    { secrets, ... }:
    {
      users.users.${user.name} = {
        createHome = true;
        description = user.desc;
        extraGroups = [
          "networkmanager"
          "systemd-journal"
          "wheel"
        ];
        hashedPasswordFile = "${secrets}/passwd/${user.name}";
        isNormalUser = true;
      };

      home-manager.users.${user.name}.imports = [
        topLevel.config.flake.modules.homeManager."user-${user.name}"
      ];
    };

  # --- демонстрационные пользовательские настройки Home Manager

  flake.modules.homeManager."user-${user.name}" =
    { config, osConfig, secrets, ... }:
    let
      # Доступ к общесистемной конфигурации
      host = osConfig.networking.hostName;
    in
    {
      # Формирование текстового файла
      home.file."hello-user.txt".text = "Hello, ${user.name}! host = ${host}.";

      age.secrets.super-secret = {
        path = "${config.home.homeDirectory}/.secrets/super-secret-file.txt";
        rekeyFile = "${secrets}/super-secret.age";
      };
    };
}
