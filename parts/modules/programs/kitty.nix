# GPU based terminal emulator: https://sw.kovidgoyal.net/kitty/
{
  flake.modules.homeManager.kitty = { lib, ... }: {

    programs.kitty = {
      enable = true;
      # https://sw.kovidgoyal.net/kitty/actions/
      keybindings = {
        "ctrl+c" = "copy_and_clear_or_interrupt";
        "ctrl+v" = "paste_selection_or_clipboard";
      };
      settings = {
        background_opacity = lib.mkForce 0.8;
        cursor_shape = "beam";
        cursor_trail = 1;
      };
    };
  };
}
