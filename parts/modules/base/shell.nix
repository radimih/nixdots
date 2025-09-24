# Оболочка по-умолчанию с минимально необходимыми настройками
{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          fish_vi_key_bindings
          set fish_greeting
          set fish_cursor_default      block
          set fish_cursor_external     line
          set fish_cursor_insert       line
          set fish_cursor_replace      underscore
          set fish_cursor_replace_one  underscore
          set fish_cursor_visual       block
        '';
      };
      users.defaultUserShell = pkgs.fish;
    };
}
