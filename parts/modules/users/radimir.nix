# flake-parts-модуль по настройке Linux-пользователя
topLevel:
let
  user = {
    name = "radimir";
    desc = "Radimir";
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

  # --- пользовательские настройки Home Manager на каждом хосте, где устанавливается пользователь

  flake.modules.homeManager."user-${user.name}" =
    { config, ... }:
    {
      programs.git = {
        enable = true;

        # user.email/name в зависимости от того, с каким удалённым репозиторием работаем
        includes =
          let
            users = [
              { domain = "github.com"; email = ""; name = ""; }
              { domain = "git.it2g.ru"; email = ""; name = ""; }
            ];
            git-includes = inputs:
              inputs
              |> builtins.map (entry:
                let
                  mkInclude = pattern: {
                    condition = "hasconfig:remote.*.url:${pattern}";
                    contents = {
                      user.email = entry.email;
                      user.name = entry.name;
                    };
                  };
                in [
                  (mkInclude "git@${entry.domain}:*/**")
                  (mkInclude "https://${entry.domain}/**")
                ])
              |> builtins.concatLists;
          in
          git-includes users;

        settings = {
          fetch = {
            all = true;
            prune = true;
            pruneTags = true;
          };
        };

        signing = {
          format = "ssh";
          key = "~/.ssh/id_ed25519";
          signByDefault = true;
        };
      };

      xdg.userDirs = {
        # TODO: уточнить каталог для документов
        documents = "${config.home.homeDirectory}/1cloud/documents";
        download = "${config.home.homeDirectory}/1temp";
      };
    };
}
