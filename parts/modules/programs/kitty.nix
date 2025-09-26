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
      # https://sw.kovidgoyal.net/kitty/conf/
      settings = {
        background = lib.mkForce "#000000";
        cursor_shape = "beam";
        cursor_trail = 1;
        # FIXME: включалась эта опция в попытках решить проблему с прозрачностью окна. Не помогло
        dynamic_background_opacity = true;
        window_padding_width = "0 1"; # отступы снизу-сверху и справа-слева
      };
    };
  };
}
