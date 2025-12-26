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
    { inputs, ...}:
    {
      users.users.${user.name} = {
        createHome = true;
        description = user.desc;
        extraGroups = [
          "networkmanager"
          "systemd-journal"
          "wheel"
        ];
        hashedPasswordFile = "${inputs.secrets}/passwd/${user.name}";
        isNormalUser = true;
      };

      home-manager.users.${user.name}.imports = [
        config.flake.modules.homeManager."user-${user.name}"
      ];
    };

  # --- пользовательские настройки Home Manager для каждого хоста, где устанавливается пользователь

  flake.modules.homeManager."user-${user.name}" =
    { config, inputs, osConfig, ... }:
    let
      host = osConfig.networking.hostName;
    in
    {
      imports = [
        inputs.agenix.homeManagerModules.default
        # inputs.agenix-rekey.homeManagerModules.default
      ];

      home.file."hello-user.txt".text = "Hello, ${user.name}! host = ${host}.";

      home.file.trial = {
        source = config.age.secrets.trial.path;
        target = "super-secret-file.txt";
      };

      age.secrets.trial.rekeyFile = "${inputs.secrets}/trial.age";

      xdg.userDirs = {
        # TODO: уточнить каталог для документов
        documents = "${config.home.homeDirectory}/1cloud/documents";
        download = "${config.home.homeDirectory}/1temp";
      };
    };
}
