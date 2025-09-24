# GPU based terminal emulator: https://sw.kovidgoyal.net/kitty/
{
  flake.modules.homeManager.kitty = {

    programs.kitty = {
      enable = true;
      settings = {
        cursor_trail = 1;
      };
    };
  };
}
