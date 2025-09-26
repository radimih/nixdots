# GPU based terminal emulator: https://sw.kovidgoyal.net/kitty/
{
  flake.modules.homeManager.kitty = {

    programs.kitty = {
      enable = true;
      # https://sw.kovidgoyal.net/kitty/actions/
      keybindings = {
        "ctrl+c" = "copy_and_clear_or_interrupt";
        "ctrl+v" = "paste_selection_or_clipboard";
      };
      # https://sw.kovidgoyal.net/kitty/conf/
      settings = {
        cursor_shape = "beam";
        cursor_trail = 1;
        dynamic_background_opacity = true;
        window_padding_width = "3 3";  # отступы снизу-сверху и справа-слева
      };
    };
  };
}
