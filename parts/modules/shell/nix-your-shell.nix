# Включение оболочки пользователя вместо bash в командах `nix-shell` и `nix shell`
{
  flake.modules.homeManager.shell = {

    programs.nix-your-shell.enable = true;
  };
}
