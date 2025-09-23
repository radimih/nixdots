{
  flake.modules.homeManager.fish =
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
        # plugins = with pkgs.fishPlugins; [
        #   {
        #     name = "autopair";
        #     src = autopair.src;
        #   }
        # ];
      plugins =
        let
          plug = name: {
            inherit name;
            src = pkgs.fishPlugins.${name}.src;
          };
        in
        [
          (plug "autopair")  # https://github.com/jorgebucaran/autopair.fish
          (plug "puffer")  # https://github.com/nickeb96/puffer-fish
        ];
      };
    };
}
