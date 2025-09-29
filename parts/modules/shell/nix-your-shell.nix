# Использование оболочки пользователя в командах `nix-shell` и `nix shell`
{
  # TODO: по промпту не видно, что мы находимся внутри вложенной оболочки (не проверено на starship)
  flake.modules.homeManager.shell = {

    # programs.nix-your-shell.enable = true;
  };
}
