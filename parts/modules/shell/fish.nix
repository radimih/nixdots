# fish: https://fishshell.com
{
  flake.modules.homeManager.shell =
    { config, pkgs, ...}:
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

          # fzf-fish: освободить комбинацию Ctrl+V (Search Variables) --> Alt+Ctrl+V
          fzf_configure_bindings --variables=\e\cv
        '';
        plugins =
          let
            plug = name: {
              inherit name;
              src = pkgs.fishPlugins.${name}.src;
            };
          in
          # Список доступных плагинов: https://search.nixos.org/packages?query=fishPlugins
          [
            (plug "autopair")  # https://github.com/jorgebucaran/autopair.fish
            (plug "fzf-fish")  # https://github.com/PatrickF1/fzf.fish
            (plug "puffer")  # https://github.com/nickeb96/puffer-fish
            (plug "sponge")  # https://github.com/meaningful-ooo/sponge
          ];
        shellInitLast = ''
          # Сделать более ярким автодополнение (base02 --> base03)
          set fish_color_autosuggestion ${config.lib.stylix.colors.base03}
        '';
    };
  };
}
