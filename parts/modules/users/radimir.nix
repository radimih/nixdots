# flake-parts-модуль по настройке Linux-пользователя
{
  config',
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
    { config, inputs, ...}:
    {
      users.users.${user.name} = {
        createHome = true;
        description = user.desc;
        extraGroups = [
          "networkmanager"
          "systemd-journal"
          "wheel"
        ];
        hashedPasswordFile = config.vaultix.secrets."${user.name}-passwd".path;
        isNormalUser = true;
      };

      home-manager.users.${user.name}.imports = [
        config'.flake.modules.homeManager."user-${user.name}"
      ];

      vaultix = {
        secrets = {
          "${user.name}-passwd" = {
            file = inputs.self + /secrets/${user.name}-passwd.age;
          };
        };
        beforeUserborn = [
          "${user.name}-passwd"
        ];
      };
    };

  # --- пользовательские настройки Home Manager для каждого хоста, где устанавливается пользователь

  flake.modules.homeManager."user-${user.name}" =
    { osConfig, config, ... }:
    let
      host = osConfig.networking.hostName;
    in
    {
      home.file."hello-user.txt".text = "Hello, ${user.name}! host = ${host}.";

      xdg.userDirs = {
        # TODO: уточнить каталог для документов
        documents = "${config.home.homeDirectory}/1cloud/documents";
        download = "${config.home.homeDirectory}/1temp";
      };
    };
}
