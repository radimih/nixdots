# Использование оболочки пользователя в командах `nix-shell` и `nix develop`
{
  flake.modules.homeManager.shell = {

    programs.nix-your-shell.enable = true;
  };
}
